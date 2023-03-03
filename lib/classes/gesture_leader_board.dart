import 'package:asl_quiz/asl_resources/asl_image.dart';

enum LeaderBoardItemEnum {
  missed,
  passed,
}

class LeaderBoardItem {
  final int count;
  final LeaderBoardItemEnum leaderBoardItemEnum;
  late final ASLImage aslImage;
  LeaderBoardItem({required this.count, required String aslName, required this.leaderBoardItemEnum}) {
    aslImage = ASLImage(name: aslName);
  }
}

class GestureLeaderBoard {
  final Map<String, int> _missedLetters = {};
  final Map<String, int> _passedLetters = {};

  int get numberOfLeaderBoardItems => _missedLetters.length + _passedLetters.length;

  void addMissed({required ASLImage aslImage}) => _missedLetters[aslImage.name] = (_missedLetters[aslImage.name] ?? 0) + 1;

  void passedLetters({required ASLImage aslImage}) => _passedLetters[aslImage.name] = (_passedLetters[aslImage.name] ?? 0) + 1;

  void reset() {
    _missedLetters.clear();
    _passedLetters.clear();
  }

  List<LeaderBoardItem> leaderBoardList() {
    final List<LeaderBoardItem> result = [];
    _missedLetters.forEach((key, value) {
      result.add(LeaderBoardItem(count: value, aslName: key, leaderBoardItemEnum: LeaderBoardItemEnum.missed));
    });
    _passedLetters.forEach((key, value) {
      result.add(LeaderBoardItem(count: value, aslName: key, leaderBoardItemEnum: LeaderBoardItemEnum.passed));
    });
    return result;
  }
}
