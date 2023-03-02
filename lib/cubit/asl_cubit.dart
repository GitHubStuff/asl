import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../asl_resources/asl_image.dart';
import '../asl_resources/asl_model.dart';
import '../classes/score.dart';

part 'asl_state.dart';

class AslCubit extends Cubit<AslState> {
  AslCubit() : super(AslInitial());

  ASLModel aslModel = ASLModel();
  ASLImage? currentImage;

  void startQuiz() {
    Future.delayed(const Duration(milliseconds: 250), () {
      aslModel.startQuiz();
      emit(AslQuizReady());
    });
  }

  void finishQuiz() => Future.delayed(const Duration(milliseconds: 500), () {
        emit(AslInitial());
      });

  void getRandomGesture() {
    currentImage = aslModel.randomGesture();
    final int count = aslModel.tally;
    emit(currentImage == null ? AslQuizOver(aslModel.score!) : AslShowGesture(count, currentImage!));
  }

  void response(String letter) {
    // ASL-zero and ASL-letter(o) look the same, so handle that case
    bool match = false;
    switch (letter) {
      case '0':
      case 'o':
        match = currentImage!.name == 'o' || currentImage!.name == '0';
        break;
      case '2':
      case 'v':
        match = currentImage!.name == 'v' || currentImage!.name == '2';
        break;
      default:
        match = currentImage!.matched(letter);
    }
    if (match) {
      getRandomGesture();
    } else {
      aslModel.score?.wrongAnswer();
      emit(WrongAnswer(wrong: ASLImage(name: letter), correct: currentImage!));
    }
  }
}
