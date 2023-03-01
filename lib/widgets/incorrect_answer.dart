import 'package:flutter/material.dart';

import '../asl_resources/asl_resources.dart';
import '../screens/asl_quiz_page.dart';

const _textStyle = TextStyle(fontSize: 24.0);

class IncorrectAnswer extends StatelessWidget {
  const IncorrectAnswer({
    super.key,
    required this.guess,
    required this.answer,
  });

  final ASLImage guess;
  final ASLImage answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You guessed "${guess.name}"',
          style: _textStyle,
        ),
        Text(
          'The Correct answer is "${answer.name}"',
          style: _textStyle,
        ),
        const SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [guess.answer, answer.answer],
        ),
        ElevatedButton(
          onPressed: () => cubit.getRandomGesture(),
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
