import 'package:asusu_igbo_f/shared/shared.dart';
import 'package:asusu_igbo_f/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/logic.dart';

void runAfia4App() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  return runApp(
    MyApp(),
  );
}

void main() async {
  runAfia4App();
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (_) => ProductRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<SearchRepository>(
          create: (_) => SearchRepository(),
        ),
        RepositoryProvider<ProductModel>(
          create: (_) => ProductModel(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) =>
                  AuthenticationBloc(userRepo: context.read<UserRepository>())
                    ..add(AppStarted())),
          BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(
                  userRepo: context.read<UserRepository>(),
                  authbloc: context.read<AuthenticationBloc>())),
          BlocProvider<UserBloc>(
            create: (BuildContext context) =>
                UserBloc()..add(FetchUserDetailsEvent()),
          ),
          BlocProvider<ProductBloc>(
            create: (BuildContext context) =>
                ProductBloc(productRepo: context.read<ProductRepository>())
                  ..add(FetchPromotedProductsEvent()),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) => CartBloc()..add(LoadCart()),
          ),
          BlocProvider<SearchBloc>(
              create: (BuildContext context) =>
                  SearchBloc(searchRepo: context.read<SearchRepository>())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'EN'),
            theme: ThemeData(
              fontFamily: 'FiraCode',
              primarySwatch: mcLavenderBlush,
            ),
            onGenerateRoute: _appRouter.onGenerateRoute),
      ),
    );
  }
}
