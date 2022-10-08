import 'package:asusu_igbo_f/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserRegisterCubit(),
        child: Scaffold(
            backgroundColor: smokyBlack,
            body: SingleChildScrollView(child: UserRegisterForm())));
  }
}
