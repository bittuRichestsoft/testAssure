// To parse this JSON data, do
//
//     final authenticationResponse = authenticationResponseFromJson(jsonString);

import 'dart:convert';

AuthenticationResponse authenticationResponseFromJson(String str) => AuthenticationResponse.fromJson(json.decode(str));

String authenticationResponseToJson(AuthenticationResponse data) => json.encode(data.toJson());

class AuthenticationResponse {
  AuthenticationResponse({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => AuthenticationResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.formStep,
    this.token,
  });

  int id;
  String email;
  int formStep;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    formStep: json["form_step"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "form_step": formStep,
    "token": token,
  };
}
