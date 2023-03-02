import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

const double _symbolHeight = 100.0;
const double _textHeight = 150.0;

class ASLImage {
  static const placeholder = 'placeholder';
  Image get aslPlaceHolder => Assets.asl1024.image(height: 100);
  final String name;
  ASLImage({required this.name});
  Image get gesture => (name == placeholder)
      ? aslPlaceHolder
      : Image(
          image: AssetImage('assets/images/asl_$name.png'),
          height: _symbolHeight,
          fit: BoxFit.fitHeight,
        );
  Image get answer => (name == placeholder)
      ? aslPlaceHolder
      : Image(
          image: AssetImage('assets/images/study_$name.png'),
          height: _textHeight,
          fit: BoxFit.fitHeight,
        );
  bool matched(String string) => name.toLowerCase() == string.toLowerCase();
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
