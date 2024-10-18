import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/auth_bloc/auth_event.dart';
import 'package:learning_app_bloc/blocs/auth_bloc/auth_state.dart';
import 'package:learning_app_bloc/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginButtonPressedEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await AuthRepository()
            .login(email: event.email, password: event.password);
        emit(AuthSuccessState());
      } catch (error) {
        if (error is LoginFailureException) {
          emit(AuthErrorState(
              emailError: error.emailError,
              passwordError: error.passwordError));
        } else {
          emit(AuthFailureState());
        }
      }
    });
    on<EmailReEnteredEvent>(
      (event, emit) {
        emit(AuthErrorState(
            emailError: null, passwordError: event.passwordError));
      },
    );
    on<PasswordReEnteredEvent>(
      (event, emit) {
        emit(AuthErrorState(emailError: event.emailError, passwordError: null));
      },
    );
  }
}
