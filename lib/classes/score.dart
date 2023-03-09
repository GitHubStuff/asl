class Score {
  final int totalImages;
  late int correctImages;
  String get scoreAsString => ((correctImages.toDouble() / totalImages.toDouble() * 100.toDouble())).toStringAsFixed(0);

  bool get isPerfectScore => correctImages == totalImages;

  Score({required this.totalImages}) {
    correctImages = totalImages;
  }

  void wrongAnswer() => --correctImages;
}
