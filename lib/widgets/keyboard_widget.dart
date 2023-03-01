import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  KeyboardWidget({Key? key, required List<Widget> keys}) : super(key: key) {
    _keyboard.addAll(keys);
  }

  final double width = 300.0;
  final List<Widget> _keyboard = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Wrap(
          children: [for (Widget key in _keyboard) key],
        ));
  }
}
