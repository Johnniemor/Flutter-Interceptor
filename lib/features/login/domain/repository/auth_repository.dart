import 'package:app_interceptor_rt/core/error/failures.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure , AuthEntity>> login(String username , String password , String deviceId);
  Future<Either<Failure , AuthEntity>> refreshToken(String refreshToken);
}