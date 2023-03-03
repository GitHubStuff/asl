part of 'gesture_cubit.dart';

@immutable
abstract class GestureState {}

class GestureInitial extends GestureState {}

class GestureStateStartQuiz extends GestureState {}

class GestureStateQuizLoaded extends GestureState {
  final GestureQuizModel gestureQuizModel;
  final CrossFadeState crossFadeState;
  final ASLImage? questionImage;
  final bool showToast;
  GestureStateQuizLoaded({
    required this.gestureQuizModel,
    required this.crossFadeState,
    required this.questionImage,
    this.showToast = false,
  });
}

class GestureStateRevealGestures extends GestureState {}

class GestureStateShowLeaderBoard extends GestureState {}
