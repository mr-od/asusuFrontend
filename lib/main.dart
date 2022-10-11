import 'package:asusu_igbo_f/shared/shared.dart';
import 'package:asusu_igbo_f/ui/home/home.dart';
import 'package:asusu_igbo_f/ui/router.dart';
import 'package:asusu_igbo_f/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/logic.dart';
import '../shared/styles/shared_colors.dart' as a4_style;
import 'ui/home/landing.dart';
import '../ui/intro/intro_screen.dart';

void runAfia4App() async {
  final authbloc = AuthenticationBloc(userRepo: UserRepoImpl());

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  return runApp(
    MyApp(
      authbloc: authbloc,
    ),
  );
}

void main() async {
  runAfia4App();
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  final AuthenticationBloc authbloc;
  final AppRouter _appRouter = AppRouter();

  MyApp({
    Key? key,
    required this.authbloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(userRepo: UserRepoImpl())
                  ..add(AppStarted())),
        BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(userRepo: UserRepoImpl(), authbloc: authbloc)),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(userRepo: UserRepoImpl()),
        ),
        BlocProvider<ProductBloc>(
          create: (BuildContext context) =>
              ProductBloc(productRepo: ProductRepoImpls()),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc()..add(LoadCart()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'EN'),
          theme: ThemeData(
            fontFamily: 'FiraCode',
            primarySwatch: mcLavenderBlush,
          ),
          onGenerateRoute: _appRouter.onGenerateRoute),
    );
  }
}
