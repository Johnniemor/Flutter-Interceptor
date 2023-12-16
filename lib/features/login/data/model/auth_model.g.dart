// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      message: json['message'] as String,
      token: TokenModel.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'message': instance.message,
      'data': instance.token,
      'statusCode': instance.statusCode,
    };
