class AuthEvent {}

class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressedEvent({
    required this.email,
    required this.password,
  });
}

class EmailReEnteredEvent extends AuthEvent {
  final String? passwordError;
  EmailReEnteredEvent({required this.passwordError});
}

class PasswordReEnteredEvent extends AuthEvent {
  final String? emailError;
  PasswordReEnteredEvent({required this.emailError});
}
