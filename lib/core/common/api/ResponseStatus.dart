// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/core/common/models/success_model.dart';
import 'package:yuktidea_flutter_deveoper_task/core/config/constants.dart';
import 'package:yuktidea_flutter_deveoper_task/core/utils/shared_preference.dart';
import 'package:yuktidea_flutter_deveoper_task/route.dart';

import '../models/error_model.dart';
import 'CustomException.dart';

dynamic ResponseStatus(
    http.Client client, Function callAgain, http.Response response) {
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
      refreshTokenMethod(client, callAgain);
      break;
    // throw UnauthorisedException(
    //     ErrorModel.fromJson(json.decode(response.body)).message);
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

Future refreshTokenMethod(http.Client client, [Function? callAgain]) async {
  http.Response? response;
  Logger().d("refresh method  called.....");
  try {
    response = await client.get(
      Uri.parse('${AppConstants.baseUrl}refresh'),
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader:
            'Bearer ${Storage.getString(AppConstants.tokenkey)}'
      },
    );
    Logger().d(response.statusCode);
    if (response.statusCode == 200) {
      Logger().d(response.body.toString());
      Storage.setString(
          AppConstants.tokenkey,
          SuccessModel.fromJson(json.decode(response.body))
              .data[0]
              .accessToken);
      callAgain!();
    } else {
      Logger().d(response.body.toString());
      // refresh token is wrong so log out user.
      // accessToken = null;
      Storage.prefsInstance!.clear();
      Navigator.pushNamedAndRemoveUntil(
          AppNavigator.navigatorKey.currentContext!,
          Paths.login,
          (route) => false);
      // _storage.deleteAll();
    }
  } on SocketException {
    throw FetchDataException(message: 'No Internet connection');
  } catch (e) {
    throw UnauthorisedException(json.decode(response!.body.toString()));
  }
}

// Future<Map<String, dynamic>> refresh() async {
//   var responseJson;
//   http.Client client = http.Client();
//   try {
//     final response = await client
//         .get(Uri.parse('${AppConstants.baseUrl}refresh'), headers: {
//       "Accept": "application/json",
//       'Content-Type': 'application/json'
//     });
//     Logger().d(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {}
//     Logger().d(responseJson);
//   } on SocketException {
//     throw FetchDataException(
//       message: 'No Internet connection, Please try again',
//     );
//   }
//   return responseJson;
// }
