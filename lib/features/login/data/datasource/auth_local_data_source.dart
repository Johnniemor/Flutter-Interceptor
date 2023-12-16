import 'package:app_interceptor_rt/core/constant/key/key_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource{
  Future<void> saveAccessToken({required String accessToken});
  Future<void> saveRefreshToken({required String refreshToken});
  Future<String> getAccessToken();
  Future<String> getRefreshToken();
  Future<void> deleteAccessToken();
  Future<void> deleteRefreshToken();
}


@LazySingleton(as: AuthLocalDataSource )
class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> deleteAccessToken() async {
   return  await secureStorage.delete(key: KeyConstants.accessToken);
  }
  
  @override
  Future<void> deleteRefreshToken() async {
    return await secureStorage.delete(key: KeyConstants.refreshToken);
  }
  
  @override
  Future<String> getAccessToken()  async{
    return await secureStorage.read(key: KeyConstants.accessToken) ?? "";
  }
  
  @override
  Future<String> getRefreshToken() async {
   return await secureStorage.read(key: KeyConstants.refreshToken) ?? "";
  }
  
  @override
  Future<void> saveAccessToken({required String accessToken})  async{
    await secureStorage.write(key: KeyConstants.accessToken, value: "Bearer $accessToken");
  }
  
  @override
  Future<void> saveRefreshToken({required String refreshToken}) async {
    await secureStorage.write(key: KeyConstants.refreshToken, value: "Bearer $refreshToken");
  }
}