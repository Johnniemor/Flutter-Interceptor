import 'package:app_interceptor_rt/core/constant/api/api_constant.dart';
import 'package:app_interceptor_rt/features/login/data/model/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';


part 'auth_service.g.dart';

@lazySingleton
@RestApi(baseUrl: baseUrl)
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(loginUrl)
  Future<AuthModel> login(
    @Body() LoginBody loginBody,
  );

  // Refresh Token Service....
  @POST(refrestTokenUrl)
  Future<AuthModel> refreshToken(
    @Header('Authorization') String refreshToken,
  );
}

@JsonSerializable()
class LoginBody {
  final String username;
  final String password;
  final String deviceId;

  const LoginBody(this.username, this.password, this.deviceId);

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
