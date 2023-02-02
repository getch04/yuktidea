import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/domain/models/register_model.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());

        var response = await repository.login(event.loginModel);
        response.fold((l) => emit(LoginFailure(l.toString())),
            (r) => emit(LoginSuccess()));
      }
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        var response = await repository.register(event.registerModel);
        response.fold((l) => emit(RegisterFailure(l.toString())),
            (r) => emit(RegisterSuccess()));
      }
      if (event is OtpEvent) {
        emit(OtpLoading());
        // var response = await repository.Otp(event.phone);
        // response.fold((l) => emit(OtpFailure(l.toString())),
        //     (r) => emit(OtpSuccess()));
      }
    });
  }
}
