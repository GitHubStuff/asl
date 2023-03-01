import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../asl_resources/asl_resources.dart';
import '../classes/keyboard_key.dart';
import '../cubit/asl_cubit.dart';
import '../widgets/incorrect_answer.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/score_widget.dart';
import 'home_scaffold.dart';

final AslCubit cubit = Modular.get<AslCubit>();

class ASLQuizPage extends StatelessWidget {
  static const route = '/ASLQuizPage';

  const ASLQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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
    return BlocBuilder<AslCubit, AslState>(
        bloc: cubit,
        builder: (context, state) {
          debugPrint(state.toString());
          if (state is AslInitial) cubit.startQuiz();
          if (state is AslQuizReady) cubit.getRandomGesture();
          if (state is AslQuizOver) {
            return Column(
              children: [
                ScoreWidget(score: state.score),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate(HomeScaffold.route);
                    cubit.finishQuiz();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          }
          if (state is AslShowGesture) {
            final column = Column(
              children: [
                state.aslImage.gesture,
                KeyboardWidget(keys: [
                  for (String item in aslLetters)
                    KeyboardKey(content: Text(item)).widget(callback: () {
                      cubit.response(item);
                    }),
                ]),
                Text('Remaining: ${state.tally}'),
              ],
            );
            return column;
          }
          if (state is WrongAnswer) {
            return IncorrectAnswer(guess: state.guess, answer: state.answer);
          }
          return Text('Hello ${state.toString()}');
        });
  }
}
