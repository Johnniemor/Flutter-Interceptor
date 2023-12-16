import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class Noparams extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoginParams extends Equatable{
  final String username;
  final String password;
  final String deviceId;

  const LoginParams({required this.username, required this.password, required this.deviceId});
  
  @override
  List<Object?> get props => [
    username , password , deviceId
  ];
}


class RefreshTokenParams extends Equatable{
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});
  
  @override
  List<Object?> get props => [refreshToken];
}