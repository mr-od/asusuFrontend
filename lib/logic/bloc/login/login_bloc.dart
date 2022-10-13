import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../logic.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository? userRepo;
  final AuthenticationBloc authbloc;

  LoginBloc({required this.userRepo, required this.authbloc})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          final token = await userRepo!.login(event.username, event.password);
          authbloc.add(LoggedIn(token: token, username: event.username));
          emit(LoginSuccess());
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}
