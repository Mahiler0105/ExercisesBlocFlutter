part of 'register_cubit.dart';

enum FormStatus {
  valid,
  invalid,
  validating,
  posting
}

class RegisterState extends Equatable{
  final FormStatus status;
  final bool isValid;
  final Username  username;
  final Email email;
  final Password password;

  const RegisterState({this.isValid = false, this.status = FormStatus.invalid, this.username = const Username.pure(), this.email = const Email.pure(), this.password = const Password.pure()});

  RegisterState  copyWith({
    FormStatus? status,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password
}) => RegisterState(
    status: status ?? this.status,
    email: email ?? this.email,
    isValid: isValid ?? this.isValid,
    password: password ?? this.password,
    username: username ?? this.username
  );

  @override
  List<Object?> get props => [status, isValid, username, email, password];
}
