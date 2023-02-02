// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/core/utils/shared_preference.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/domain/models/register_model.dart';

import '../../../../core/common/api/CustomException.dart';
import '../../../../core/common/api/ResponseStatus.dart';
import '../../../../core/config/constants.dart';
import 'package:http_retry/http_retry.dart';

abstract class AuthDataSource {
  /// Calls the [URL] endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map<String, dynamic>> login(Map<String, dynamic> loginModel);
  Future<Map<String, dynamic>> register(RegisterModel registerModel);
  Future<Map<String, dynamic>> otpSend();
  Future<Map<String, dynamic>> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  // final http.Client client;
  var client = RetryClient(
    http.Client(),
    retries: 1,
    when: (response) {
      return response.statusCode == 401 ? true : false;
    },
    onRetry: (req, res, retryCount) {
      if (retryCount == 0 && res?.statusCode == 401) {
        // refresh token
        Logger().d("token expitreddddd....");
      }
    },
  );
  AuthDataSourceImpl({required this.client});
  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> loginModel) async {
    var responseJson;
    try {
      final response = await client.post(
          Uri.parse('${AppConstants.baseUrl}login'),
          body: jsonEncode(loginModel),
          headers: {'Content-Type': 'application/json'});
      Logger().d(response.body);
      responseJson = ResponseStatus(response);
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection, Please try again',
      );
    }
    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> register(RegisterModel registerModel) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}register'),
        body: registerModel.toJson(),
      );
      Logger().d(response.body);
      responseJson = ResponseStatus(response);
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection, Please try again',
      );
    }
    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> otpSend() async {
    var responseJson;
    String TOKEN = Storage.getString(AppConstants.tokenkey);
    Logger().d(TOKEN);
    try {
      final response = await client
          .post(Uri.parse('${AppConstants.baseUrl}otp/verify'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $TOKEN"
      });
      Logger().d(response.body);
      responseJson = ResponseStatus(response);
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection, Please try again',
      );
    }
    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    var responseJson;
    String TOKEN = Storage.getString(AppConstants.tokenkey);
    Logger().d(TOKEN);
    try {
      final response = await client
          .get(Uri.parse('${AppConstants.baseUrl}logout'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $TOKEN"
      });
      Logger().d(response.body);
      responseJson = ResponseStatus(response);
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection, Please try again',
      );
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> refreshToken() async {
    var responseJson;

    String TOKEN = Storage.getString(AppConstants.tokenkey);
    Logger().d(TOKEN);
    try {
      final response = await client
          .post(Uri.parse('${AppConstants.baseUrl}refresh'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $TOKEN"
      });
      Logger().d(response.body);
      responseJson = ResponseStatus(response);
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection, Please try again',
      );
    }
    return responseJson;
  }
}
