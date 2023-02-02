part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

//login states
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String msg;
  const LoginFailure(this.msg);
}

//redister states
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String msg;
  const RegisterFailure(this.msg);
}

//OTP states
class OtpLoading extends AuthState {}

class OtpSuccess extends AuthState {}

class OtpFailure extends AuthState {
  final String msg;
  const OtpFailure(this.msg);
}
