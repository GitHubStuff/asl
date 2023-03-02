import 'asl_image.dart';
import 'asl_model.dart';

class GestureQuizModel extends ASLModel {
  List<ASLImage> gestures = [];
  List<ASLImage> previousGestures = [];

  @override
  void startQuiz() {
    super.startQuiz();
    gestures = previousGestures = [];
    ASLImage? loaderImage = randomASLImage();
    while (loaderImage != null) {
      gestures.add(loaderImage);
      loaderImage = randomASLImage();
      previousGestures.add(ASLImage(name: ASLImage.placeholder));
    }
  }
}
