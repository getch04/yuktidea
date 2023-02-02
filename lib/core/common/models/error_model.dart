// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

class ErrorModel {
  ErrorModel({
    required this.status,
    required this.message,
    required this.error,
  });

  bool status;
  String message;
  List<String> error;

  factory ErrorModel.fromRawJson(String str) =>
      ErrorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        message: json["message"],
        error: List<String>.from(json["error"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": List<dynamic>.from(error.map((x) => x)),
      };
}
