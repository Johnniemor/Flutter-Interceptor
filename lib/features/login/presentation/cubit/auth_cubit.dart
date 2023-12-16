import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/config/routes/routes.dart';
import 'package:app_interceptor_rt/config/routes/routes.gr.dart';
import 'package:app_interceptor_rt/core/usecase/use_case.dart';
import 'package:app_interceptor_rt/features/login/data/datasource/auth_local_data_source.dart';
import 'package:app_interceptor_rt/features/login/domain/entities/auth_entity.dart';
import 'package:app_interceptor_rt/features/login/domain/usecase/auth_use_case.dart';
import 'package:app_interceptor_rt/features/login/domain/usecase/refresh_token_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase _authUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final AuthLocalDataSource _localDataSource;


  AuthCubit(this._authUseCase, this._refreshTokenUseCase, this._localDataSource) : super(const AuthState.initial());

  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());
    
      final response = await _authUseCase(LoginParams(
          username: username, password: password, deviceId: "800001222"));
      response.fold((l) {
        emit(AuthState.failure(l.message));
      }, (result) {
        emit(AuthState.sucess(result));
        // print(result);
        refreshToken();
      });
  }


  Future<void> refreshToken() async{
    emit(const AuthState.loading());
    final refreshToken = await _localDataSource.getRefreshToken();
    final response = await _refreshTokenUseCase(RefreshTokenParams(refreshToken: refreshToken));
    response.fold((l) {
      emit(AuthState.failure(l.message));
    }, (result) {
      emit(AuthState.sucess(result));
      // print("Refresh token response : $result");
    });
  }


  Future<void> logOut() async{
 try {
      await _localDataSource.deleteAccessToken();
      getIt<AppRouter>().replaceAll([LoginRoute()]);
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }
}
