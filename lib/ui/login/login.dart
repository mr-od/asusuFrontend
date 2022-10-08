import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';

import '../../logic/logic.dart';
import '../../shared/components/shared_components.dart';
import '../ui.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginForm(),
      backgroundColor: a4_style.smokyBlack,
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
      child: Form(
        child: Column(
          children: [
            Container(
                height: 200.0,
                padding: const EdgeInsets.only(bottom: 20.0, top: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "FiraCode",
                          color: a4_style.lavenderBlush,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        // height: 5.0,
                        child: Image.asset(
                          'assets/icons/A4logo.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    const Text(
                      "Login to Asusu",
                      style: TextStyle(
                          fontFamily: "FiraCode",
                          fontSize: 10.0,
                          color: a4_style.lavenderBlush),
                    )
                  ],
                )),
            const SizedBox(
              height: 30.0,
            ),
            _username(),
            const SizedBox(
              height: 20.0,
            ),
            _password(),
            const SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                        fontFamily: "FiraCode",
                        color: a4_style.lavenderBlush,
                        fontSize: 12.0),
                  ),
                  onTap: () {}),
            ),
            // _loginButton(state, _onLoginButtonPressed),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Login Failed. Try Again',
                        style: TextStyle(fontFamily: "FiraCode")),
                    backgroundColor: a4_style.amaranth,
                  ));
                }
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Login Successful.',
                      style: TextStyle(fontFamily: "FiraCode"),
                    ),
                    backgroundColor: a4_style.actionSuccesful,
                  ));
                  goTo(context, const LandingPage());
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: 45,
                          child: state is LoginLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 25.0,
                                          width: 25.0,
                                          child: CupertinoActivityIndicator(),
                                        )
                                      ],
                                    ))
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: a4_style.amaranth),
                                        primary: a4_style.pureBlack,
                                        onSurface: a4_style.amaranth,
                                        surfaceTintColor: a4_style.amaranth,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                              username:
                                                  _usernameController.text,
                                              password:
                                                  _passwordController.text),
                                        );
                                      },
                                      child: const Text("LOG IN",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                              color: a4_style.lavenderBlush))),
                                )),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.grey, fontFamily: "FiraCode"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 5.0),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RegisterScreen()));
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: a4_style.amaranth,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FiraCode"),
                            ))
                      ],
                    )),
              ),
            ),
            // const SizedBox(
            //   height: 20.0,
            // )
          ],
        ),
      ),
    );
  }

  TextFormField _password() {
    return TextFormField(
      style: const TextStyle(
          fontSize: 14.0,
          color: a4_style.lavenderBlush,
          fontWeight: FontWeight.normal),
      controller: _passwordController,
      decoration: InputDecoration(
        fillColor: a4_style.lavenderBlush,
        prefixIcon: SizedBox(
          height: 35,
          width: 35,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/icons/rlock.png',
              fit: BoxFit.contain,
              height: 35,
              width: 35,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: a4_style.amaranth),
            borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: a4_style.lavenderBlush),
            borderRadius: BorderRadius.circular(15.0)),
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        labelText: "Password",
        hintStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: "FiraCode"),
        labelStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: "FiraCode"),
      ),
      autocorrect: false,
      obscureText: true,
    );
  }

  TextFormField _username() {
    return TextFormField(
      style: const TextStyle(
          fontSize: 14.0,
          color: a4_style.lavenderBlush,
          fontWeight: FontWeight.normal),
      controller: _usernameController,
      keyboardType: TextInputType.name,
      // validator: (value) => LoginEmailValidator().isValidUsername
      //     ? null
      //     : 'Username is too short',
      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/icons/profile.png',
              fit: BoxFit.contain,
              height: 35,
              width: 35,
            )),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: a4_style.amaranth),
            borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: a4_style.lavenderBlush),
            borderRadius: BorderRadius.circular(15.0)),
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        labelText: "Username",
        hintStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: "FiraCode"),
        labelStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: "FiraCode"),
      ),
      autocorrect: false,
    );
  }
}
