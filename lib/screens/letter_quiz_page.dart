import 'package:asl_quiz/asl_resources/asl_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../classes/keyboard_key.dart';
import '../cubit/letter_cubit.dart';
import '../widgets/keyboard_widget.dart';
import 'home_scaffold.dart';

final LetterCubit letterCubit = Modular.get<LetterCubit>();

class LetterQuizPage extends StatefulWidget {
  static const route = '/LetterQuizPage';

  const LetterQuizPage({super.key});

  @override
  State<LetterQuizPage> createState() => _LetterQuizPage();
}

class _LetterQuizPage extends State<LetterQuizPage> {
  bool _revealGestures = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.navigate(HomeScaffold.route);
            letterCubit.finishQuiz();
          },
        ),
        title: const Text('Enter ASL letter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bloc(),
          ],
        ),
      ),
    );
  }

  Widget bloc() {
    return BlocBuilder<LetterCubit, LetterState>(
        bloc: letterCubit,
        builder: (context, state) {
          debugPrint(state.toString());
          if (state is LetterInitial) letterCubit.startQuiz();
          if (state is LetterStateQuizLoaded) {
            return _showGestures(state: state);
          }
          return const CircularProgressIndicator();
        });
  }

  Widget _showGestures({required LetterStateQuizLoaded state}) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!_revealGestures) {
        setState(() {
          _revealGestures = true;
        });
      }
    });
    return Wrap(children: [
      KeyboardWidget(keys: [
        for (ASLImage item in state.gestureQuizModel.gestures)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: AnimatedCrossFade(
              crossFadeState: !_revealGestures ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 750),
              firstChild: KeyboardKey(content: ASLImage.aslPlaceHolder).widget(callback: () {
                debugPrint(item.name);
              }),
              secondChild: KeyboardKey(content: item.gesture).widget(callback: () {
                debugPrint(item.name);
              }),
            ),
          ),
      ])
    ]);
  }
}
