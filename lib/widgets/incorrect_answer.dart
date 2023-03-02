import 'package:flutter/material.dart';

import '../asl_resources/asl_image.dart';
import '../screens/asl_quiz_page.dart';

const _textStyle = TextStyle(fontSize: 24.0);

class IncorrectAnswer extends StatelessWidget {
  const IncorrectAnswer({
    super.key,
    required this.incorrect,
    required this.correct,
  });

  final ASLImage incorrect;
  final ASLImage correct;

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait ? _portraitMode() : _landscapeMode();

  Widget _button() => ElevatedButton(
        onPressed: () => cubit.getRandomGesture(),
        child: const Text('Continue'),
      );

  Widget _landscapeMode() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: kids(),
          ),
          _button(),
        ],
      );
  Widget _portraitMode() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: kids()..add(_button()),
      );

  List<Widget> kids() => [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              incorrect.wrong(),
              style: _textStyle,
            ),
            incorrect.answer,
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 56),
              child: Text(
                correct.correction(),
                style: _textStyle,
              ),
            ),
            correct.answer,
          ],
        ),
        const SizedBox(height: 24.0),
      ];
}
