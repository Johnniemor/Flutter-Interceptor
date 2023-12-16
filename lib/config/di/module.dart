import 'package:app_interceptor_rt/config/routes/routes.dart';
import 'package:app_interceptor_rt/core/middleware/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModule {
  // Register injection for auto router
  @lazySingleton
  AppRouter get routes => AppRouter();


  // Register Dio & Interceptor 
  @lazySingleton
  Dio dio(@Named('appInterceptors') AppInterceptors appInterceptors) {
    final dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.interceptors.add(appInterceptors);
    dio.options.connectTimeout = const Duration(seconds: 60 * 1);
    dio.options.receiveTimeout = const Duration(seconds: 60 * 1);
    return dio;
  }

  // Register injection for Flutter Secure Storage ( save data on local storage )
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
