import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/asl_cubit.dart';
import 'home_scaffold.dart';
import 'asl_quiz_page.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AslCubit()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    //ChildRoute('/', child: (_, __) => ScaffoldWidget(title: 'empty_package')),
    ChildRoute('/', child: (_, __) => const HomeScaffold()),
    ChildRoute('/ASLQuizPage', child: (context, args) => const ASLQuizPage()),
  ];
}
