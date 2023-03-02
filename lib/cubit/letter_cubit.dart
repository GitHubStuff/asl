import 'package:asl_quiz/asl_resources/gesture_quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'letter_state.dart';

class LetterCubit extends Cubit<LetterState> {
  LetterCubit() : super(LetterInitial());

  GestureQuizModel gestureQuizModel = GestureQuizModel();

  void startQuiz() {
    Future.delayed(const Duration(milliseconds: 250), () {
      gestureQuizModel.startQuiz();
      emit(LetterStateQuizLoaded(gestureQuizModel: gestureQuizModel, showTiles: false));
    });
  }

  void reveal() {
    emit(LetterStateRevealGestures());
  }

  void finishQuiz() => Future.delayed(const Duration(milliseconds: 500), () {
        emit(LetterInitial());
      });
}
