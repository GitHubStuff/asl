import '../classes/my_sequence.dart';
import '../classes/score.dart';
import 'asl_image.dart';

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
