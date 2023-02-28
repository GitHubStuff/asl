import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/riverpod.dart';
import 'screens/app_module.dart';
import 'theme/app_theme.dart';
import 'theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.setup();

  runApp(
    ProviderScope(
      child: ModularApp(
        module: AppModule(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget with AppThemes {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      //locale: Language.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.mode,
      localizationsDelegates: const [],
    );
  }
}
