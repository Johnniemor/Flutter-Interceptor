import 'dart:io';

import 'package:app_interceptor_rt/core/error/exceptions.dart';
import 'package:app_interceptor_rt/core/error/failures.dart';
import 'package:app_interceptor_rt/core/service/auth_service.dart';
import 'package:app_interceptor_rt/core/util/response_helper.dart';
import 'package:app_interceptor_rt/features/login/data/model/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource{
  Future<AuthModel> login(String username , String password);
  Future<AuthModel> refreshToken(String refreshToken);
}


@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final AuthService _authService;

  AuthRemoteDataSourceImpl(this._authService);
  
  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      return await _authService.login(LoginBody(username, password));
    } on DioException catch (e) {
      throw ResponseHelper.returnResponse(e);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on SocketException catch (e) {
      throw ServerFailure(e.message);
    } on ConnectionException catch (e) {
      throw ConnectionFailure(e.message);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
  
  @override
  Future<AuthModel> refreshToken(String refreshToken) async {
    try{
      return await _authService.refreshToken(refreshToken);
    } on DioException catch (e) {
      throw ResponseHelper.returnResponse(e);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on SocketException catch (e) {
      throw ServerFailure(e.message);
    } on ConnectionException catch (e) {
      throw ConnectionFailure(e.message);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}