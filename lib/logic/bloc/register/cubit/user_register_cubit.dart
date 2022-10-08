import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/dio_client.dart';
import '../../../../shared/network/url_endpoint.dart';
import '../../../logic.dart';

part 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  UserRegisterCubit() : super(UserRegisterInitialState());

  static UserRegisterCubit get(context) => BlocProvider.of(context);

  UserRegisterModel? registerModel;

  void userRegister({
    required String username,
    required String email,
    required String password,
    required String fullname,

    // required String phone,
  }) {
    emit(UserRegisterLoadingState());

    DioClient().postData(
      url: registerEP,
      data: {
        'username': username,
        'email': email,
        'password': password,
        'full_name': fullname,
      },
    ).then((value) {
      registerModel = UserRegisterModel.fromJson(value.data);
      emit(UserRegisterSuccessState(registerModel!));
    }).catchError((error) {
      emit(UserRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(UserRegisterChangePasswordVisibilityState());
  }
}
