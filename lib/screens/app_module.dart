import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/asl_cubit.dart';
import '../cubit/gesture_cubit.dart';
import 'asl_quiz_page.dart';
import 'gesture_quiz_page.dart';
import 'home_scaffold.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AslCubit()),
    Bind.lazySingleton((i) => GestureCubit()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    //ChildRoute('/', child: (_, __) => ScaffoldWidget(title: 'empty_package')),
    ChildRoute('/', child: (_, __) => const HomeScaffold()),
    ChildRoute(ASLQuizPage.route, child: (context, args) => const ASLQuizPage()),
    ChildRoute(GestureQuizPage.route, child: (context, args) => const GestureQuizPage()),
  ];
}
