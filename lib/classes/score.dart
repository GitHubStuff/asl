class Score {
  final int totalImages;
  late int correctImages;
  String get score => (correctImages.toDouble() / totalImages.toDouble()).toStringAsFixed(2);

  Score({required this.totalImages}) {
    correctImages = totalImages;
  }

  void wrongAnswer() => --correctImages;
}
