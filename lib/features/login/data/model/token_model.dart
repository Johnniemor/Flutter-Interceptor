import 'package:app_interceptor_rt/features/login/domain/entities/token_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@JsonSerializable()
class TokenModel extends TokenEntity {
    @JsonKey(name: "access_token")
    final String accessToken;
    @JsonKey(name: "refresh_token")
    final String refreshToken;

    const TokenModel({
        required this.accessToken,
        required this.refreshToken,
    }) : super(accessTokenEntity: accessToken, refreshTokenEntity: refreshToken);

    factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

    Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}