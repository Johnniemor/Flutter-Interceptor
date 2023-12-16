import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/config/routes/routes.dart';
import 'package:app_interceptor_rt/config/routes/routes.gr.dart';
import 'package:app_interceptor_rt/core/constant/api/api_constant.dart';
import 'package:app_interceptor_rt/features/login/data/datasource/auth_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

@Named('appInterceptors')
@lazySingleton
class AppInterceptors extends Interceptor {
  final AuthLocalDataSource _authLocalDataSource;

  AppInterceptors(this._authLocalDataSource);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _authLocalDataSource.getAccessToken();
    final refrestToken = await _authLocalDataSource.getRefreshToken();

    bool tokenHasExpired(String? accessToken) {
      if (kDebugMode) {
        print("Access Token : $accessToken");
      }
      if (accessToken == null || accessToken == "") {
        return false;
      } else {
        return JwtDecoder.isExpired(accessToken);
      }
    }

    options.headers.addAll({"Accept-Language": "en"});
    if (tokenHasExpired(accessToken)) {
      try {
        final dio = Dio();
        options.baseUrl = baseUrl;
        options.headers.addAll({"Authorization": accessToken});
        dio.options.headers = {"Authorization": refrestToken};
        dio.options.baseUrl = baseUrl;
        final response = await dio.post(refrestTokenUrl);
        final newRefreshToken = response.data['data']['refresh_token'].toString();
        final newToken = response.data['data']['access_token'].toString();
        await _authLocalDataSource.saveAccessToken(accessToken: newToken);
        await _authLocalDataSource.saveRefreshToken(refreshToken: newRefreshToken);
        if (kDebugMode) {
          print("New token : $newToken");
        }
        if (kDebugMode) {
          print("New Refresh Token : $newRefreshToken");
        }
      } on DioException catch (err) {
        if (kDebugMode) {
          print(err.message);
        }
        if (kDebugMode) {
          print(err.response?.data);
        }
        await _authLocalDataSource.deleteAccessToken();
        await _authLocalDataSource.deleteRefreshToken();
        getIt<AppRouter>().replaceAll([LoginRoute()]);
        return handler.reject(err);
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
