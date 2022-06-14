// To parse this JSON data, do
//
//     final loansInfoResponse = loansInfoResponseFromJson(jsonString);

import 'dart:convert';

LoansInfoResponse loansInfoResponseFromJson(String str) => LoansInfoResponse.fromJson(json.decode(str));

String loansInfoResponseToJson(LoansInfoResponse data) => json.encode(data.toJson());

class LoansInfoResponse {
  LoansInfoResponse({
    this.message,
    this.status,
    this.otp,
  });

  String message;
  bool status;
  String otp;

  factory LoansInfoResponse.fromJson(Map<String, dynamic> json) => LoansInfoResponse(
    message: json["message"],
    status: json["status"],
    otp: json["Otp"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "Otp": otp,
  };
}
