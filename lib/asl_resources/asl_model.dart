import '../classes/my_sequence.dart';
import '../classes/score.dart';
import 'asl_image.dart';

class ASLModel {
  static List<String> aslLetters = 'ab'.split('');
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
