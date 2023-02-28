# asl

A complete, self-contained, Flutter app that is the starting point for an **App** for iOS, MacOS, Android, and Chrome

- The outline has light, dark, and system theme mode switching using *hooks_riverpod* for state management.
- Theme mode is persisted using *hive_flutter* database.
- Dependency management and navigation is done using *flutter_modular*.

## Getting Started

### These are the steps when using VSCode

- Find/Replace `asl_quiz` to name of the flutter name of the app (ex: `my_spiffy_app`)
- Find/Replace `ASL Quiz` to a label used to name the app on mobile Platforms (ex:`My Spiffy Mobile App`)
- Find/Replace `Mac ASL Quiz` to the name of your macOS app (ex: `My Spiffy macOS App`)
- Find/Replace `icodeforyou.com` to the project down for the product/customer (ex: `apple.com`)
- Find/Replace `com.icodeforyou` with the projects **reverse domain** that the start of the apps' identifier (ex: `com.apple`)
- Find/Replace `asl` with bundle id (ex: `my_spiffy_app`) **[using the folder name is ideal]**
- Find/Replace `aslQuiz` for Apple bundles as iOS/MacOS do like '_'. **[ideal is folder name to lower-camel case (ex: `mySpiffyApp`)]**
- The image `/assets/asl1024.png` is a placeholder image to generate application icons. In the `pubspec.yaml` file is section marked *flutter_icons*:

  ```dart
  flutter_icons:
  android: 'launcher_icon'
  ios: true
  remove_alpha_ios: true
  image_path: 'assets/asl1024.png'
  macos:
    generate: true
    image_path: 'assets/asl1024.png'
  web:
    generate: true
    image_path: 'assets/asl1024.png'
  windows:
    generate: true
    image_path: 'assets/asl1024.png'

  ```

  This generates icons for the platforms by running from the terminal in the ide:

  ```dart
  % flutter pub run flutter_launcher_icons
  ```

  generating icons for iOS/Mac/Android/Web and even Windows *(Widows sucks but I guess someone has to do it.)*

  NOTE: The sample app already has the [ltmm1024x1024](assets/asl1024.png). The best images are 1024x1024. Replace the image and make sure the `image_path` in `pubspec.yaml` is updated and then run the `% flutter pub run flutter_launcher_icons` again.

- From the terminal in the IDE:

  ```dart
  % flutter clean
  % flutter pub get
  % flutter pub run build_runner build --delete-conflicting-outputs
  ```

The `build_runner` will generate `lib/gen/assets.gen.dart`, this is part of [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner), the flutter code generator for assets/fonts/colors to get rid of String-based APIs. Search `flutter_gen_runner` for an example of it's use.

All done, this is ideal first-commit for the new app.

## The template app is ready

### For ***macOS*** warnings

*IF* running ***macOS***, and there is a warning:

`The macOS deployment target 'MACOSX_DEPLOYMENT_TARGET' is set to 10.11, but the range of supported deployment target versions is 10.13 to 13.1.99. (in target 'FlutterMacOS' from project 'Pods')`

This is because *Launching/Running* an app the first time after *flutter pub get* generates serveral files that are **macOS** platform version 10.11

*WORKAROUND* Find/Replace `10.11` with `10.13` ![Only for macos path-ed files](/README/mac_os_deployment_target_workaround.png)

*NOTE* Make sure only ***macOS/*** pathed files are shown and replaced!!

### Summary of included files in /lib

- **main.dart** the entry point into the app
- **providers/riverpod.dart** place for *hooks_riverpod* providers, notifiers, and objects {see **[https://pub.dev/packages/hooks_riverpod]**}. The template has setup for changes to the app's theme mode.
- **screens/app_module.dart** where routes and injects are defined {see **[flutter_modular]([https:www.cnn.com](https://pub.dev/packages/flutter_modular))**}
- **screens/home_scaffold** the start page for the app (its path of "/" is defined in *app_module.dart*), probably the first thing to replace
- **theme/app_theme.dart** helper class to set/persist the app's theme (dark, light, system)
- **theme/app_themes.dart** template mixin for definining app specific themes
- **theme/brightness_settings.dart** this is an `enum BrightnessSetting` that expands brightness to include **application dark/light**, and **system dark/light**. Use the static method `BrightnessSetting brightnessSetting(BuildContext context)` of `AppTheme` to get the brightness and the originator of the brightness (application or system).
- **widgets/set_brightness_fab_widget/brightness_theme_action_buttons.dart** is an example (not production worthy) of creating buttons for `BrightnessSetting` that appear from an `expanded_fab` widget.
- **widgets/expandable_fab.dart** a FAB widget that takes an array of other widgets (see `fab_action_button.dart`) that will appear when the FAB button is tapped.
- **fab_action_button** helper widget the compose buttons/actions for the `expanded_fab` widget.
