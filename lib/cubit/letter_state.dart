part of 'letter_cubit.dart';

@immutable
abstract class LetterState {}

class LetterInitial extends LetterState {}

class LetterStateStartQuiz extends LetterState {}

class LetterStateQuizLoaded extends LetterState {
  final GestureQuizModel gestureQuizModel;
  final bool showTiles;
  LetterStateQuizLoaded({
    required this.gestureQuizModel,
    required this.showTiles,
  });
}

class LetterStateRevealGestures extends LetterState {}
