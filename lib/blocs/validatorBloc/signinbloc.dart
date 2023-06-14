import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinevent.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinstate.dart';

class SigninBloc extends Bloc<SignInEvent, SignInState> {
  SigninBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState(error: "Please Enter Valid Email Address"));
      } else if (event.passwordValue.length <= 4) {
        emit(SignInErrorState(error: "Please Enter a Valid Password"));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
