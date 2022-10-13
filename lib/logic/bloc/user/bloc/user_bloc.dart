import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../logic.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo = UserRepository();

  UserBloc() : super(UserLoadingState()) {
    on<FetchUserDetailsEvent>(_onFetchUser);
  }

  FutureOr<void> _onFetchUser(
      FetchUserDetailsEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final currentUser = await userRepo.getCurrentUser();
      emit(UserLoadedState(userModel: currentUser));
    } catch (error) {
      emit(UserErrorState(error: error.toString()));
    }
  }
}
