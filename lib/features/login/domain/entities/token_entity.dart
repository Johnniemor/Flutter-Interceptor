import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  final String accessTokenEntity;
  final String refreshTokenEntity;

  const TokenEntity(
      {required this.accessTokenEntity, required this.refreshTokenEntity});

  @override
  List<Object?> get props => [accessTokenEntity, refreshTokenEntity];
}
