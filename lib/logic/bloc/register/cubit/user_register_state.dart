part of 'user_register_cubit.dart';

abstract class UserRegisterState extends Equatable {
  const UserRegisterState();

  @override
  List<Object> get props => [];
}

class UserRegisterInitialState extends UserRegisterState {}

class UserRegisterLoadingState extends UserRegisterState {}

class UserRegisterSuccessState extends UserRegisterState {
  final UserRegisterModel registerModel;

  const UserRegisterSuccessState(this.registerModel);
}

class UserRegisterErrorState extends UserRegisterState {
  final String error;

  const UserRegisterErrorState(this.error);
}

class UserRegisterChangePasswordVisibilityState extends UserRegisterState {}
