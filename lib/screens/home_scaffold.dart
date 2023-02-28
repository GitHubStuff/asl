// ignore_for_file: sort_child_properties_last

import 'package:asl_quiz/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/assets.gen.dart';
import '../providers/riverpod.dart';
import '../theme/app_theme.dart';
import '../widgets/set_brightness_fab_widget/brightness_theme_action_buttons.dart';

class HomeScaffold extends ConsumerWidget {
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
    final currentThemeMode = ref.watch(themeModeProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Assets.asl1024.image(), // flutter_gen_runner
              ),
            ),
          ),
          Text('${currentThemeMode.mode.name}: ${AppTheme.brightnessSetting(context).name}'),
        ],
      ),
    );
  }
}
