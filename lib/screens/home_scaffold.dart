// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/expandable_fab.dart';
import '../widgets/set_brightness_fab_widget/brightness_theme_action_buttons.dart';
import 'asl_quiz_page.dart';
import 'letter_quiz_page.dart';

class HomeScaffold extends ConsumerWidget {
  static const route = '/';

  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: homeWidget(context, ref),
      floatingActionButton: ExpandableFab(
        distance: 120.0,
        children: fabSettingWidgets(context, ref: ref),
      ),
    );
  }

  Widget homeWidget(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => Modular.to.navigate(ASLQuizPage.route),
            child: const Text('ASL Quiz'),
          ),
          ElevatedButton(
            onPressed: () => Modular.to.navigate(LetterQuizPage.route),
            child: const Text('Gesture Quiz'),
          ),
        ],
      ),
    );
  }
}
