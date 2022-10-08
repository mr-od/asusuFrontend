import 'package:asusu_igbo_f/shared/shared.dart';
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

  const MyApp({
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
            create: (BuildContext context) =>
                UserBloc(userRepo: UserRepoImpl()),
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
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return const LandingPage();
              }
              if (state is AuthenticationUnauthenitcated) {
                return const IntroScreen();
              }
              if (state is AuthenticationLoading) {
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                a4_style.defaultColor),
                            strokeWidth: 4.0,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              a4_style.defaultColor),
                          strokeWidth: 4.0,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
