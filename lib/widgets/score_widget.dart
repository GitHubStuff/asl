import 'package:extensions_package/extensions_package.dart';
import 'package:flutter/material.dart';

import '../classes/score.dart';
import 'confetti_message.dart';

class ScoreWidget extends StatelessWidget {
  final Score score;

  const ScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    if (score.isPerfectScore) {
      return ConfettiMessage(
        overlays: [const Text('Perfect Score!').fontSize(32.0)],
      ); 
    }
    return Column(
      children: [
        Text('Score: ${score.correctImages} of ${score.totalImages}'),
        Text('${score.scoreAsString}%'),
      ],
    );
  }
}
