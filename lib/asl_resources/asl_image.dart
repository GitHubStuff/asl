import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

const double _symbolHeight = 100.0;
const double _textHeight = 150.0;

class ASLImage {
  static const placeholder = 'placeholder';
  static Image get aslPlaceHolder => Assets.asl1024.image(height: 100);
  final String name;
  ASLImage({required this.name});
  factory ASLImage.holder() => ASLImage(name: ASLImage.placeholder);
  Image get gestureImage => (name == placeholder)
      ? aslPlaceHolder
      : Image(
          image: AssetImage('assets/images/asl_$name.png'),
          height: _symbolHeight,
          fit: BoxFit.fitHeight,
        );
  Image get answerImage => (name == placeholder)
      ? aslPlaceHolder
      : Image(
          image: AssetImage('assets/images/study_$name.png'),
          height: _textHeight,
          fit: BoxFit.fitHeight,
        );

  bool matched(String userInput) {
    switch (userInput.toLowerCase()) {
      case '0':
      case 'o':
        return name == 'o' || name == '0';
      case '2':
      case 'v':
        return name == 'v' || name == '2';
      default:
        return name.toLowerCase() == userInput.toLowerCase();
    }
  }

  String wrong() {
    if (name == '0') return 'You guessed zero ';
    if (name == 'o') return 'You guessed "o" ';
    if (name == '1') return 'You guessed "1" ';
    return 'You guessed "$name" ';
  }

  String correction() {
    if (name == '0') return 'It is actually zero ';
    if (name == 'o') return 'It is actually "o" ';
    if (name == '1') return 'It is actually one ';
    return 'It is actually "$name" ';
  }
}
