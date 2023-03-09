import 'package:asl_quiz/widgets/confetti_message.dart';
import 'package:confetti/confetti.dart';
import 'package:extensions_package/extensions_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../asl_resources/asl_image.dart';
import '../classes/keyboard_key.dart';
import '../cubit/gesture_cubit.dart';
import '../widgets/gestured_leaderboard_listview.dart';
import '../widgets/keyboard_widget.dart';
import 'home_scaffold.dart';

final GestureCubit gestureCubit = Modular.get<GestureCubit>();

class GestureQuizPage extends StatefulWidget {
  static const route = '/GestureQuizPage';

  const GestureQuizPage({super.key});

  @override
  State<GestureQuizPage> createState() => _GestureQuizPage();
}

class _GestureQuizPage extends State<GestureQuizPage> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  final confettiiController = ConfettiController();

  @override
  void dispose() {
    confettiiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Modular.to.navigate(HomeScaffold.route);
              gestureCubit.finishQuiz();
            },
          ),
          title: const Text('Enter ASL letter'),
        ),
        body: bloc());
  }

  Widget bloc() {
    return BlocBuilder<GestureCubit, GestureState>(
        bloc: gestureCubit,
        builder: (context, state) {
          debugPrint(state.toString());
          if (state is GestureInitial) gestureCubit.beginQuiz();
          if (state is GestureStateShowLeaderBoard) {
            return const GestureLeaderBoardListView();
          }
          if (state is GestureStatePerfectScore) {
            return ConfettiMessage(
              overlays: [const Text('Perfect Score!').fontSize(32.0)],
            );
          }
          if (state is GestureStateQuizLoaded) {
            if (state.showToast) {
              _tryAgainToast();
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _showGestures(state: state),
                  Text('${state.remainingQuestions + 1}'),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _showGestures({required GestureStateQuizLoaded state}) {
    if (state.crossFadeState != _crossFadeState) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _crossFadeState = state.crossFadeState;
        });
      });
    }
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _dialogBuilder(context, image: state.questionImage!, crossFadeState: state.crossFadeState),
          child: Text(state.questionImage?.name ?? '').fontSize(26.0).paddingAll(4.0),
        ),
        Wrap(children: [
          KeyboardWidget(keys: [
            for (int index = 0; index < state.gestureQuizModel.numberOfGestures; index++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: AnimatedCrossFade(
                  crossFadeState: _crossFadeState,
                  duration: const Duration(milliseconds: 750),
                  firstChild: KeyboardKey(content: state.gestureQuizModel.previousAslImage(at: index).gestureImage).widget(callback: () {
                    gestureCubit.checkAnswer(
                      questionASLImage: state.questionImage!,
                      answerASLImage: state.gestureQuizModel.previousAslImage(at: index),
                      crossFadeState: CrossFadeState.showFirst,
                    );
                  }),
                  secondChild: KeyboardKey(content: state.gestureQuizModel.currentAslImage(at: index).gestureImage).widget(callback: () {
                    gestureCubit.checkAnswer(
                      answerASLImage: state.gestureQuizModel.currentAslImage(at: index),
                      questionASLImage: state.questionImage!,
                      crossFadeState: CrossFadeState.showSecond,
                    );
                  }),
                ),
              ),
          ])
        ]),
      ],
    );
  }

  void _tryAgainToast() => Future.delayed(const Duration(milliseconds: 100), () {
        Fluttertoast.showToast(
            msg: "Try Again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

  Future<void> _dialogBuilder(BuildContext context, {required ASLImage image, required CrossFadeState crossFadeState}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' "${image.name}" Revealed'),
            content: image.gestureImage,
            actions: [
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                  gestureCubit.displayNextGestures(crossFadeState: crossFadeState, passedOnImage: image);
                },
              ),
            ],
          );
        });
  }
}
