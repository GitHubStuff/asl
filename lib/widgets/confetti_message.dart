import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiMessage extends StatefulWidget {
  const ConfettiMessage({super.key, this.overlays});
  final List<Widget>? overlays;

  @override
  State<ConfettiMessage> createState() => _ConfettiMessage();
}

class _ConfettiMessage extends State<ConfettiMessage> {
  final confettiiController = ConfettiController()..duration = const Duration(seconds: 4);
  final List<Widget> _confettiWidgets = [];

  @override
  void initState() {
    super.initState();
    _confettiWidgets.add(ConfettiWidget(
      blastDirection: -pi / 2, // up
      confettiController: confettiiController,
      shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      emissionFrequency: 0.02,
      numberOfParticles: 6,
    ));
    _confettiWidgets.addAll(widget.overlays ?? []);
    _startConfettiPlaying();
  }

  @override
  void dispose() {
    confettiiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: _confettiWidgets,
        ),
      );

  void _startConfettiPlaying() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        confettiiController.play();
      });
    });
  }
}
