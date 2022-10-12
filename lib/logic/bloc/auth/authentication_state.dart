part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationVirginState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationUnauthenitcated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}
