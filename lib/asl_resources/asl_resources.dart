import 'package:flutter/material.dart';

import '../classes/my_sequence.dart';

const List<String> aslLetters = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9'
];

class ASLImage {
  final String name;
  ASLImage({required this.name});
  Image get gesture => Image(image: AssetImage('assets/images/asl_$name.png'));
  Image get answer => Image(image: AssetImage('assets/images/study_$name.png'));
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

class Score {
  final int totalImages;
  late int correctImages;
  String get score => (correctImages.toDouble() / totalImages.toDouble()).toStringAsFixed(2);

  Score({required this.totalImages}) {
    correctImages = totalImages;
  }

  void wrongAnswer() => --correctImages;
}

class ASLModel {
  MySequence<ASLImage>? _sequence;
  Score? score;
  int tally = 0;

  void startQuiz() {
    List<ASLImage> aslImages = [];
    aslLetters.asMap().forEach((_, letter) {
      aslImages.add(ASLImage(name: letter));
    });
    _sequence = MySequence(aslImages);
    tally = aslImages.length;
    score = Score(totalImages: tally);
  }

  ASLImage? randomGesture() {
    tally--;
    return _sequence?.randomItem();
  }
}
