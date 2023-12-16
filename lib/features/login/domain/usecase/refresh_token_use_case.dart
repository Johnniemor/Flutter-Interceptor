import 'package:app_interceptor_rt/core/error/failures.dart';
import 'package:app_interceptor_rt/core/usecase/use_case.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:app_interceptor_rt/features/login/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class RefreshTokenUseCase implements UseCase<Either<Failure , AuthEntity> , RefreshTokenParams>{
  final AuthRepository _authRepository;

  RefreshTokenUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;
  
  @override
  Future<Either<Failure, AuthEntity>> call(RefreshTokenParams params) async {
    return await _authRepository.refreshToken(params.refreshToken);
  }
  
  
}