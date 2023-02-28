// ignore_for_file: empty_catches
/// AppTheme is used to persist the [Brightness] setting of the application.
/// This class uses [Hive] package to store/reload changes in brightness.
/// NOTE: call to [await AppTheme.setup()] should be done in the [main] of the app.
import 'dart:io';

import 'package:app_template/theme/brightness_setting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String _boxNameForTheme = 'hive.box.name.1e1e40e586614a6d9ed12b2693738663';

class AppTheme {
  static Box? box;
  static ThemeMode _mode = ThemeMode.system;

  static ThemeMode get mode => _mode;
  static set mode(ThemeMode mode) {
    if (box == null) throw TypeError();
    box?.put(_boxNameForTheme, mode.name);
    _mode = mode;
  }

  static Future<void> setup() async {
    try {
      if (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) {
        var path = Directory.current.path;
        Hive.init(path);
      } else {
        await Hive.initFlutter();
      }
      box = await Hive.openBox<String>(_boxNameForTheme);
      mode = _translate(fromString: box!.get(_boxNameForTheme, defaultValue: ThemeMode.system.name));
    } on TypeError {
    } on MissingPluginException {
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }

  static ThemeMode _translate({required String fromString}) => ThemeMode.values.firstWhere((element) => element.name == fromString);

  static Brightness brightness(BuildContext context) {
    switch (_mode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness;
    }
  }

  static BrightnessSetting brightnessSetting(BuildContext context) {
    switch (_mode) {
      case ThemeMode.dark:
        return BrightnessSetting.applicationDark;
      case ThemeMode.light:
        return BrightnessSetting.applicationLight;
      case ThemeMode.system:
        switch (MediaQuery.of(context).platformBrightness) {
          case Brightness.dark:
            return BrightnessSetting.systemDark;
          case Brightness.light:
            return BrightnessSetting.systemLight;
        }
    }
  }
}
