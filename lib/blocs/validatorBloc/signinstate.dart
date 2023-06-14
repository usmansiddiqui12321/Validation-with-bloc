abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidState extends SignInState {}

class SignInErrorState extends SignInState {
  final String error;
  SignInErrorState({required this.error});
}

class SignInLoadingState extends SignInState {}
