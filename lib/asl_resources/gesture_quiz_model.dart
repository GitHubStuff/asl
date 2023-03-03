import 'package:asl_quiz/classes/gesture_leader_board.dart';
import 'package:flutter/material.dart';

import 'asl_image.dart';
import 'asl_model.dart';

class GestureQuizModel extends ASLModel {
  final List<ASLImage> _currentASLImages = [];
  final List<ASLImage> _previousASLImages = [];

  ASLModel _questionsModel = ASLModel();

  final GestureLeaderBoard _gestureLeaderBoard = GestureLeaderBoard();

  int get numberOfLeaderBoardItems => _gestureLeaderBoard.numberOfLeaderBoardItems;

  List<LeaderBoardItem> get leaderBoardList => _gestureLeaderBoard.leaderBoardList();

  void addToMissed(ASLImage aslImage) => _gestureLeaderBoard.addMissed(aslImage: aslImage);
  void addToPassed(ASLImage aslImage) => _gestureLeaderBoard.passedLetters(aslImage: aslImage);

  int get numberOfGestures => _currentASLImages.length;

  ASLImage? get questionASLImage => _questionsModel.randomASLImage();

  int remainingQuestions() => _questionsModel.tally;

  @override
  void startQuiz() {
    super.startQuiz();
    _questionsModel = ASLModel()..startQuiz();
    _currentASLImages.clear();
    _previousASLImages.clear();
    _gestureLeaderBoard.reset();
    ASLImage? loaderImage = randomASLImage();
    while (loaderImage != null) {
      _currentASLImages.add(loaderImage);
      loaderImage = randomASLImage();
      _previousASLImages.add(ASLImage(name: ASLImage.placeholder));
    }
  }

  ASLImage currentAslImage({required int at}) => _currentASLImages[at];
  ASLImage previousAslImage({required int at}) => _previousASLImages[at];

  void shuffleKeyboard({required CrossFadeState currentCrossFade}) {
    switch (currentCrossFade) {
      case CrossFadeState.showFirst:
        _currentASLImages.shuffle();
        break;
      case CrossFadeState.showSecond:
        _previousASLImages.clear();
        _previousASLImages.addAll(_currentASLImages);
        _previousASLImages.shuffle();
        break;
    }
  }
}
