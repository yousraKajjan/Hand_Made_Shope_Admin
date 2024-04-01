abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadinState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

class LoginVisiblePasswordState extends LoginState {}
