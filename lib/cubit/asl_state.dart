part of 'asl_cubit.dart';

@immutable
abstract class AslState {}

class AslInitial extends AslState {}

class AslQuizOver extends AslState {
  final Score score;
  AslQuizOver(this.score);
}

class AslQuizReady extends AslState {}

class AslShowGesture extends AslState {
  final int tally;
  final ASLImage aslImage;
  AslShowGesture(this.tally, this.aslImage);
}

class WrongAnswer extends AslState {
  final ASLImage guess;
  final ASLImage answer;
  WrongAnswer({required this.guess, required this.answer});
}
