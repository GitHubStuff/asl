import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../asl_resources/asl_resources.dart';

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
    if (currentImage!.matched(letter)) {
      getRandomGesture();
    } else {
      aslModel.score?.wrongAnswer();
      emit(
        WrongAnswer(wrong: ASLImage(name: letter), correct: currentImage!),
      );
    }
  }
}
