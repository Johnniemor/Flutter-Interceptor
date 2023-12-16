import 'package:app_interceptor_rt/features/login/data/model/token_model.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
    final String messageEntity;
    final TokenModel tokenEntity;
    final int statusCodeEntity;

  const AuthEntity({required this.messageEntity, required this.tokenEntity, required this.statusCodeEntity});
  
  @override
  List<Object?> get props => [messageEntity , tokenEntity , statusCodeEntity];
}