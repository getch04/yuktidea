part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final Map<String, dynamic> loginModel;

  const LoginEvent(this.loginModel);
}

class RegisterEvent extends AuthEvent {
  final RegisterModel registerModel;

  const RegisterEvent(this.registerModel);
}

class OtpEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
