// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'package:app_interceptor_rt/features/login/data/model/token_model.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'auth_model.g.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

@JsonSerializable()
class AuthModel extends AuthEntity {
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "data")
    final TokenModel token;
    @JsonKey(name: "statusCode")
    final int statusCode;

    const AuthModel({
        required this.message,
        required this.token,
        required this.statusCode,
    }) : super(messageEntity: message, tokenEntity: token, statusCodeEntity: statusCode);

    factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

    Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
