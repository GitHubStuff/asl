part of 'letter_cubit.dart';

@immutable
abstract class LetterState {}

class LetterInitial extends LetterState {}

class LetterStateStartQuiz extends LetterState {}

class LetterStateQuizReady extends LetterState {
  final List<ASLImage> tiles;
  final List<ASLImage> previous;
  LetterStateQuizReady({required this.tiles, required this.previous});
}
