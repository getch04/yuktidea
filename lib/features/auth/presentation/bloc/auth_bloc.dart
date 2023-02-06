import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/core/common/models/success_model.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/constants.dart';
import 'package:yuktidea_flutter_deveoper_task/core/utils/shared_preference.dart';
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
        response.fold((l) => emit(LoginFailure(l.toString())), (r) {
          Logger().d(r);
          var token = SuccessModel.fromJson(r).data[0].accessToken;
          Logger().d(token);
          Storage.setString(AppConstants.tokenkey, token);
          emit(LoginSuccess());
        });
      }
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        var response = await repository.register(event.registerModel);
        response.fold((l) => emit(RegisterFailure(l.toString())), (r) {
          var token = SuccessModel.fromJson(r).data[0].accessToken;
          Storage.setString(AppConstants.tokenkey, token);
          Logger().i(Storage.getString(AppConstants.tokenkey));
          emit(RegisterSuccess());
        });
      }
      if (event is OtpEvent ) {
        emit(OtpLoading());
        var res = await repository.otpSend();
        res.fold((l) => emit(OtpFailure(l)), (r) => emit(OtpSuccess(code: r)));
      }
      if (event is LogoutEvent) {
        emit(LogoutLoading());
        var res = await repository.logout();
        res.fold((l) => emit(LogoutFailure()), (r) {
          emit(LogoutSuccess());
          Storage.prefsInstance!.clear();
        });
      }
    });
  }
}
