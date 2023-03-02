import 'package:asl_quiz/asl_resources/asl_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../classes/keyboard_key.dart';
import '../cubit/letter_cubit.dart';
import '../widgets/keyboard_widget.dart';
import 'home_scaffold.dart';

final LetterCubit letterCubit = Modular.get<LetterCubit>();

class LetterQuizPage extends StatelessWidget {
  static const route = '/LetterQuizPage';

  const LetterQuizPage({super.key});

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
          if (state is LetterStateQuizReady) return _showGestures(state: state);
          return const Text('Zerk');
        });
  }

  Widget _showGestures({required LetterStateQuizReady state}) {
    return Wrap(children: [
      KeyboardWidget(keys: [
        for (ASLImage item in state.previous)
          KeyboardKey(content: item.answer).widget(callback: () {
            debugPrint('x');
          }),
      ])
    ]);
  }
}
