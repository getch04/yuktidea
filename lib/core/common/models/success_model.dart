// To parse this JSON data, do
//
//     final successModel = successModelFromJson(jsonString);

import 'dart:convert';

class SuccessModel {
    SuccessModel({
        required this.status,
        required this.message,
        required this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory SuccessModel.fromRawJson(String str) => SuccessModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
    });

    String accessToken;
    String tokenType;
    int expiresIn;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}
