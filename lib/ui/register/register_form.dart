import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/shared_colors.dart' as a4_style;
import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../ui.dart';

class UserRegisterForm extends StatelessWidget {
  UserRegisterForm({
    Key? key,
  }) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserRegisterCubit, UserRegisterState>(
      listener: (context, state) {
        if (state is UserRegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Registration Successful. Verify Email then Login'),
            backgroundColor: a4_style.registerSuccesful,
            duration: Duration(seconds: 30),
          ));
          goToUntil(
            context,
            const LoginScreen(),
          );
        }
      },
      child: BlocBuilder<UserRegisterCubit, UserRegisterState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RegisterTitleColumn(),
                const SizedBox(
                  height: 30.0,
                ),
                defaultFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Username Invalid';
                    }
                    return null;
                  },
                  label: 'User Name',
                  prefix: 'assets/icons/profile.png',
                ),
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email Invalid';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: 'assets/icons/rmail.png',
                ),
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffix: UserRegisterCubit.get(context).suffix,
                  onSubmit: (value) {},
                  isPassword: UserRegisterCubit.get(context).isPassword,
                  suffixPressed: () {
                    UserRegisterCubit.get(context).changePasswordVisibility();
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password Invalid';
                    }
                    return null;
                  },
                  label: 'Password',
                  prefix: 'assets/icons/rlock.png',
                ),
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                  controller: fullnameController,
                  keyboardType: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter your full name';
                    }
                    return null;
                  },
                  label: 'Full Name',
                  prefix: 'assets/icons/profile.png',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                (state is! UserRegisterLoadingState)
                    ? defaultButton(
                        radius: 30,
                        buttonColor: a4_style.pureBlack,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            UserRegisterCubit.get(context).userRegister(
                              username: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              fullname: fullnameController.text,
                            );
                          }
                        },
                        text: 'register',
                        isUpperCase: true,
                      )
                    : Center(
                        child: AdaptiveIndicator(
                        os: getOS(),
                      )),
                const HaveAccount(),
              ],
            ),
          );
        },
      ),
    );
    // return Container();
  }
}

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "I have an account?",
              style: TextStyle(color: Colors.grey, fontFamily: "FiraCode"),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: a4_style.amaranth,
                      fontWeight: FontWeight.bold,
                      fontFamily: "FiraCode"),
                ))
          ],
        ));
  }
}

class RegisterTitleColumn extends StatelessWidget {
  const RegisterTitleColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 25),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "REGISTER",
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
              "Register for an Account in Asusu",
              style: TextStyle(
                  fontFamily: "FiraCode",
                  fontSize: 10.0,
                  color: a4_style.lavenderBlush),
            ),
          ],
        ),
      ),
    );
  }
}
