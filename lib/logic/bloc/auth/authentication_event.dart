part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String username;

  const LoggedIn({required this.token, required this.username});

  @override
  List<Object> get props => [token, username];

  @override
  String toString() => 'LoggedIn {$token, with $username}';
}

class LoggedOut extends AuthenticationEvent {}

class Registered extends AuthenticationEvent {
  final String username;
  const Registered({required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'Registered {$username}';
}

class NoVendorLoggedState extends AuthenticationEvent {}
