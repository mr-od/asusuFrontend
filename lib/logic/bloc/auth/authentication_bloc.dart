import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../logic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository? userRepo;
  AuthenticationBloc({required this.userRepo})
      : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      // emit(AuthenticationVirginState());
      // await Future<void>.delayed(const Duration(seconds: 5));
      if (event is AppStarted) {
        final bool readToken = await userRepo!.readToken();
        if (readToken) {
          emit(AuthenticationAuthenticated());
        } else {
          emit(AuthenticationUnauthenitcated());
        }
      }
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await userRepo!.saveToken(event.token);
        await userRepo!.saveUsername(event.username);

        debugPrint('Save Token Event: ${event.token}');

        emit(AuthenticationAuthenticated());
      }
      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await userRepo!.deleteToken();
        await Future<void>.delayed(const Duration(seconds: 10));

        emit(AuthenticationUnauthenitcated());
      }
    });
  }
}
