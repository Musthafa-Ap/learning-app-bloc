class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? emailError;
  final String? passwordError;
  AuthErrorState({this.emailError, this.passwordError});
}

class AuthFailureState extends AuthState {}
