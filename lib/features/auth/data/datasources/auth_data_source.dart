// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/domain/models/register_model.dart';

import '../../../../core/Api/CustomException.dart';
import '../../../../core/common/api/ResponseStatus.dart';
import '../../../../core/config/constants.dart';

abstract class AuthDataSource {
  /// Calls the [URL] endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map<String, dynamic>> login(Map<String, dynamic> loginModel);
  Future<Map<String, dynamic>> register(RegisterModel registerModel);
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;

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
}
