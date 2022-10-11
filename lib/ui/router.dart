import 'package:asusu_igbo_f/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/logic.dart';
import '../shared/shared.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocListener<AuthenticationBloc,
                    AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationUninitialized) {
                    Navigator.of(context).pushNamed("/intro");
                  }
                  if (state is AuthenticationAuthenticated) {
                    Navigator.of(context).pushNamed("/landing");
                  }
                  if (state is AuthenticationUnauthenitcated) {
                    Navigator.of(context).pushNamed("/login");
                  }
                  if (state is AuthenticationLoading) {
                    Scaffold(
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(defaultColor),
                                strokeWidth: 4.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  Scaffold(
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(defaultColor),
                              strokeWidth: 4.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: const IntroScreen()));
      case '/intro':
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case '/landing':
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case '/promoted':
        return MaterialPageRoute(builder: (_) => const PromotedProducts());
      case '/myprofile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                  "No Screen Route was specified for ${routeSettings.name}"),
            ),
          ),
        );
    }
  }
}
