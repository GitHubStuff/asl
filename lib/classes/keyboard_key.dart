import 'package:flutter/material.dart';

class KeyboardKey<T> {
  final Size size;
  final T content;

  const KeyboardKey({
    required this.content,
    this.size = const Size(46, 46),
  });

  Widget widget({VoidCallback? callback}) => InkWell(
        onTap: callback,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Center(child: (content is String) ? Text(content as String) : content as Widget),
        ),
      );
}
