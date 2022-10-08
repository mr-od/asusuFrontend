part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

//////// Fetch User Details State /////////////

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final SingleUserModel userModel;

  const UserLoadedState({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class UserErrorState extends UserState {
  final String error;

  const UserErrorState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'User Loading Failure {$error}';
}
