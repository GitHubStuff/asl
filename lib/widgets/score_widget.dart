import 'package:flutter/material.dart';

import '../asl_resources/asl_resources.dart';

class ScoreWidget extends StatelessWidget {
  final Score score;

  const ScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Score: ${score.correctImages} of ${score.totalImages}'),
        Text(score.score),
      ],
    );
  }
}
