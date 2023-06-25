// import 'package:bloc_exercises/presentation/blocs/register/register_state.dart';
import 'package:bloc_exercises/infrastructure/inputs/inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(const RegisterState());

  void onSubmit(){
    emit(state.copyWith(
      status: FormStatus.validating,
      username: Username.dirty(state.username.value),
      password: Password.dirty(state.password.value),
      email: Email.dirty(state.email.value),
      isValid: Formz.validate([state.username, state.password])
    ));
    print(state.toString());
  }

  void usernameChanged(String value){
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([username, state.password, state.email]),
    ));
  }
  void emailChanged(String value){
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.username, state.password]),
    ));
  }
  void passwordChanged(String  value){
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.username, password, state.email]),
    ));
  }
}
