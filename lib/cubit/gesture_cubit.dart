import 'package:asl_quiz/asl_resources/asl_image.dart';
import 'package:asl_quiz/asl_resources/gesture_quiz_model.dart';
import 'package:asl_quiz/classes/gesture_leader_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gesture_state.dart';

class GestureCubit extends Cubit<GestureState> {
  GestureCubit() : super(GestureInitial());

  GestureQuizModel _gestureQuizModel = GestureQuizModel();

  int get numberOfLeaderBoardItems => _gestureQuizModel.numberOfLeaderBoardItems;

  List<LeaderBoardItem> get leaderBoardList => _gestureQuizModel.leaderBoardList;

  void beginQuiz() {
    Future.delayed(const Duration(milliseconds: 250), () {
      _gestureQuizModel = GestureQuizModel()..startQuiz();
      emit(GestureStateQuizLoaded(
        gestureQuizModel: _gestureQuizModel,
        crossFadeState: CrossFadeState.showSecond,
        remainingQuestions: _gestureQuizModel.remainingQuestions(),
        questionImage: _gestureQuizModel.questionASLImage,
      ));
    });
  }

  void checkAnswer({
    required ASLImage questionASLImage,
    required ASLImage answerASLImage,
    required CrossFadeState crossFadeState,
  }) {
    final String question = questionASLImage.name;
    final bool correct = answerASLImage.matched(question);
    if (correct) {
      displayNextGestures(crossFadeState: crossFadeState);
    } else {
      _displayTryAgain(
        crossFadeState: crossFadeState,
        questionImage: questionASLImage,
      );
    }
  }

  void reveal() {
    emit(GestureStateRevealGestures());
  }

  void finishQuiz() => Future.delayed(const Duration(milliseconds: 500), () {
        emit(GestureInitial());
      });

  void displayNextGestures({required CrossFadeState crossFadeState, ASLImage? passedOnImage}) {
    if (passedOnImage != null) _gestureQuizModel.addToPassed(passedOnImage);
    Future.delayed(const Duration(milliseconds: 250), () {
      final ASLImage? nextQuestion = _gestureQuizModel.questionASLImage;
      if (nextQuestion == null) {
        emit(_gestureQuizModel.numberOfLeaderBoardItems == 0 ? GestureStatePerfectScore() : GestureStateShowLeaderBoard());
        return;
      }

      _gestureQuizModel.shuffleKeyboard(currentCrossFade: crossFadeState);
      CrossFadeState newState = (crossFadeState == CrossFadeState.showFirst) ? CrossFadeState.showSecond : CrossFadeState.showFirst;
      emit(GestureStateQuizLoaded(
          gestureQuizModel: _gestureQuizModel, crossFadeState: newState, questionImage: nextQuestion, remainingQuestions: _gestureQuizModel.remainingQuestions()));
    });
  }

  void _displayTryAgain({required CrossFadeState crossFadeState, required ASLImage questionImage}) {
    _gestureQuizModel.addToMissed(questionImage);
    emit(GestureStateQuizLoaded(
      gestureQuizModel: _gestureQuizModel,
      crossFadeState: crossFadeState,
      questionImage: questionImage,
      remainingQuestions: _gestureQuizModel.remainingQuestions(),
      showToast: true,
    ));
  }
}
