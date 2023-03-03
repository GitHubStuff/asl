import '../classes/my_sequence.dart';
import '../classes/score.dart';
import 'asl_image.dart';

const List<String> aslLetters = [
  'a',
  'b',
  'c',
  'd', /*
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
  '9' */
];

class ASLModel {
  MySequence<ASLImage>? _sequence;
  ASLImage? _currentImage;
  Score? score;
  int tally = 0;

  ASLImage? get currentImage => _currentImage;

  bool nameMatch(String letter) => _currentImage?.matched(letter) ?? false;

  void _loadSequence() {
    List<ASLImage> aslImages = [];
    aslLetters.asMap().forEach((_, letter) {
      aslImages.add(ASLImage(name: letter));
    });
    _sequence = MySequence(aslImages);
  }

  void startQuiz() {
    _loadSequence();
    tally = _sequence?.count ?? 0;
    score = Score(totalImages: tally);
  }

  ASLImage? randomASLImage() {
    tally--;
    _currentImage = _sequence?.randomItem();
    return _currentImage;
  }
}
