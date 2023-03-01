import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  KeyboardWidget({Key? key, required List<Widget> keys}) : super(key: key) {
    _keyboard.addAll(keys);
  }

  final double width = 300.0;
  final List<Widget> _keyboard = [];

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait ? _portraitMode() : _landscapeMode();

  Widget _portraitMode() => SizedBox(
        width: 300,
        child: Wrap(
          children: [for (Widget key in _keyboard) key],
        ),
      );

  Widget _landscapeMode() => SizedBox(
        width: 560,
        child: Wrap(
          children: [for (Widget key in _keyboard) key],
        ),
      );
}
