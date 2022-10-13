import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

import '../../../logic.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;

  UserBloc({required this.userRepo}) : super(UserInitialState()) {
    on<FetchUserDetailsEvent>((event, emit) async {
      try {
        emit(UserLoadingState());
        final currentUser = await userRepo.getCurrentUser();
        await Future<void>.delayed(const Duration(seconds: 10));

        emit(UserLoadedState(userModel: currentUser));
        // debugPrint('User Loaded : $UserLoadedState()');
      } catch (error) {
        emit(UserErrorState(error: error.toString()));
      }
    });
  }
}
