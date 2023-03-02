import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../asl_resources/asl_image.dart';
import '../asl_resources/asl_model.dart';
import '../classes/score.dart';

part 'asl_state.dart';

class AslCubit extends Cubit<AslState> {
  AslCubit() : super(AslInitial());

  ASLModel _aslModel = ASLModel();

  void startQuiz() {
    Future.delayed(const Duration(milliseconds: 250), () {
      _aslModel = ASLModel()..startQuiz();
      emit(AslQuizReady());
    });
  }

  void finishQuiz() => Future.delayed(const Duration(milliseconds: 500), () {
        emit(AslInitial());
      });

  void getRandomGesture() {
    final ASLImage? currentImage = _aslModel.randomASLImage();
    final int count = _aslModel.tally;
    emit(currentImage == null ? AslQuizOver(_aslModel.score!) : AslShowGesture(count, currentImage));
  }

  void response(String letter) {
    assert(_aslModel.currentImage != null);

    if (_aslModel.currentImage!.matched(letter)) {
      getRandomGesture();
    } else {
      _aslModel.score?.wrongAnswer();
      emit(WrongAnswer(wrong: ASLImage(name: letter), correct: _aslModel.currentImage!));
    }
  }
}
