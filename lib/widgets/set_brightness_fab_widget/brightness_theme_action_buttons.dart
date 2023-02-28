/// Collection of FAB buttons for different types of brightness (SystemLite/Dark AppLite/Dark)
import 'package:app_template/theme/brightness_setting.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/riverpod.dart';
import '../fab_action_button.dart';

List<Widget> fabSettingWidgets(BuildContext context, {required WidgetRef ref}) {
  final List<Widget> buttons = [
    _applicationDark(context, ref: ref),
    _applicationLight(context, ref: ref),
  ];
  bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  buttons.add(isDark ? _systemDark(context, ref: ref) : _systemLight(context, ref: ref));
  return buttons;
}

Widget _systemDark(BuildContext context, {required WidgetRef ref}) => FabActionButton(
      onPressed: () {
        _setTheme(ref, mode: ThemeMode.system);
        _showAction(context, content: 'System Dark');
      },
      icon: Icon(BrightnessSetting.systemDark.icon),
    );

Widget _systemLight(BuildContext context, {required WidgetRef ref}) => FabActionButton(
      onPressed: () {
        _setTheme(ref, mode: ThemeMode.system);
        _showAction(context, content: 'System Light');
      },
      icon: Icon(BrightnessSetting.systemLight.icon),
    );

Widget _applicationDark(BuildContext context, {required WidgetRef ref}) => FabActionButton(
      onPressed: () {
        _setTheme(ref, mode: ThemeMode.dark);
        _showAction(context, content: 'Application Dark');
      },
      icon: Icon(BrightnessSetting.applicationDark.icon),
    );
Widget _applicationLight(BuildContext context, {required WidgetRef ref}) => FabActionButton(
      onPressed: () {
        _setTheme(ref, mode: ThemeMode.light);
        _showAction(context, content: 'Application Light');
      },
      icon: Icon(BrightnessSetting.applicationLight.icon),
    );

void _setTheme(WidgetRef ref, {required ThemeMode mode}) {
  final themeModeNotifier = ref.read(themeModeProvider.notifier);
  switch (mode) {
    case ThemeMode.dark:
      themeModeNotifier.changeToDarkMode();
      return;
    case ThemeMode.light:
      themeModeNotifier.changeToLightMode();
      return;
    case ThemeMode.system:
      themeModeNotifier.changeToSystemMode();
      return;
  }
}

void _showAction(BuildContext context, {required String content}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              size: 64.0,
            ),
          ),
        ],
      );
    },
  );
}
