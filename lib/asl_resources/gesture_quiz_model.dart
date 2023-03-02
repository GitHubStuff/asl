import 'asl_image.dart';
import 'asl_model.dart';

class GestureQuizModel extends ASLModel {
  List<ASLImage> screen = [];
  List<ASLImage> preview = [];

  @override
  void startQuiz() {
    super.startQuiz();
    ASLImage? loaderImage = randomGesture();
    while (loaderImage != null) {
      preview.add(ASLImage(name: ASLImage.placeholder));
      screen.add(loaderImage);
      loaderImage = randomGesture();
    }
  }
}
