import 'dart:io';

import 'package:app_interceptor_rt/core/error/exceptions.dart';
import 'package:app_interceptor_rt/core/error/failures.dart';
import 'package:app_interceptor_rt/features/login/data/datasource/auth_local_data_source.dart';
import 'package:app_interceptor_rt/features/login/data/datasource/auth_remote_data_source.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:app_interceptor_rt/features/login/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> login(
      String username, String password) async {
    try {
      final response =
          await _remoteDataSource.login(username, password);
      await _localDataSource.saveAccessToken(
          accessToken: response.token.accessToken);
      await _localDataSource.saveRefreshToken(
          refreshToken: response.token.refreshToken);
      return (Right(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    try {
      final response = await _remoteDataSource.refreshToken(refreshToken);
      return (Right(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message.toString()));
    }
  }
}
