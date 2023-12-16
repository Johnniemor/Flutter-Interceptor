import 'package:app_interceptor_rt/core/error/failures.dart';
import 'package:app_interceptor_rt/core/usecase/use_case.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:app_interceptor_rt/features/login/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class AuthUseCase implements UseCase<Either<Failure , AuthEntity> , LoginParams >{
  final AuthRepository _authRepository;

  AuthUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;
  @override
  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
   return await _authRepository.login(params.username, params.password);
  }
  
}