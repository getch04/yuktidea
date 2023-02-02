// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/error_model.dart';
import 'CustomException.dart';

dynamic ResponseStatus(http.Response response) {
  // Logger().d(response.statusCode);
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body);
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      Logger().d(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(
          ErrorModel.fromJson(json.decode(response.body)).message);
    case 401:
      Logger().d(ErrorModel.fromJson(json.decode(response.body)).message);
      throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(response.body)).message);
    case 403:
      throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(response.body)).message);
    case 500:
    default:
      throw FetchDataException(
          message:
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
