import 'dart:math';

class MySequence<T> {
  final List<T> _activeList = [];
  final List<T> _sourceList = [];
  final Random _random = Random();

  int get count => _activeList.length;

  MySequence(List<T> items) {
    _activeList.addAll(items);
    _sourceList.addAll(items);
  }

  T? randomItem({bool repeating = false}) {
    final int count = _activeList.length;
    if (count == 0) {
      if (!repeating) return null;
      _activeList.addAll(_sourceList);
      return randomItem(repeating: true);
    }
    final int index = _random.nextInt(count);
    final T result = _activeList[index];
    _activeList.removeAt(index);
    return result;
  }

  T? nextItem({bool repeating = false}) {
    if (_activeList.isEmpty) {
      if (!repeating) return null;
      _activeList.addAll(_sourceList);
    }
    final result = _activeList.first;
    _activeList.removeAt(0);
    return result;
  }

  void reset() {
    _activeList.clear();
    _activeList.addAll(_sourceList);
  }
}
