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
  const LoginParams({required this.username, required this.password});
  
  @override
  List<Object?> get props => [
    username , password 
  ];
}


class RefreshTokenParams extends Equatable{
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});
  
  @override
  List<Object?> get props => [refreshToken];
}