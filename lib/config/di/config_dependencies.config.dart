// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_interceptor_rt/config/di/module.dart' as _i15;
import 'package:app_interceptor_rt/config/routes/routes.dart' as _i3;
import 'package:app_interceptor_rt/core/middleware/interceptors.dart' as _i6;
import 'package:app_interceptor_rt/core/service/auth_service.dart' as _i8;
import 'package:app_interceptor_rt/features/login/data/datasource/auth_local_data_source.dart'
    as _i5;
import 'package:app_interceptor_rt/features/login/data/datasource/auth_remote_data_source.dart'
    as _i9;
import 'package:app_interceptor_rt/features/login/data/repository/auth_repository_impl.dart'
    as _i11;
import 'package:app_interceptor_rt/features/login/domain/repository/auth_repository.dart'
    as _i10;
import 'package:app_interceptor_rt/features/login/domain/usecase/auth_use_case.dart'
    as _i12;
import 'package:app_interceptor_rt/features/login/domain/usecase/refresh_token_use_case.dart'
    as _i13;
import 'package:app_interceptor_rt/features/login/presentation/cubit/auth_cubit.dart'
    as _i14;
import 'package:dio/dio.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i3.AppRouter>(() => injectionModule.routes);
    gh.lazySingleton<_i4.FlutterSecureStorage>(
        () => injectionModule.secureStorage);
    gh.lazySingleton<_i5.AuthLocalDataSource>(
        () => _i5.AuthLocalDataSourceImpl(gh<_i4.FlutterSecureStorage>()));
    gh.lazySingleton<_i6.AppInterceptors>(
      () => _i6.AppInterceptors(gh<_i5.AuthLocalDataSource>()),
      instanceName: 'appInterceptors',
    );
    gh.lazySingleton<_i7.Dio>(() => injectionModule
        .dio(gh<_i6.AppInterceptors>(instanceName: 'appInterceptors')));
    gh.lazySingleton<_i8.AuthService>(() => _i8.AuthService(gh<_i7.Dio>()));
    gh.lazySingleton<_i9.AuthRemoteDataSource>(
        () => _i9.AuthRemoteDataSourceImpl(gh<_i8.AuthService>()));
    gh.lazySingleton<_i10.AuthRepository>(() => _i11.AuthRepositoryImpl(
          gh<_i5.AuthLocalDataSource>(),
          gh<_i9.AuthRemoteDataSource>(),
        ));
    gh.lazySingleton<_i12.AuthUseCase>(
        () => _i12.AuthUseCase(authRepository: gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i13.RefreshTokenUseCase>(() =>
        _i13.RefreshTokenUseCase(authRepository: gh<_i10.AuthRepository>()));
    gh.factory<_i14.AuthCubit>(() => _i14.AuthCubit(
          gh<_i12.AuthUseCase>(),
          gh<_i13.RefreshTokenUseCase>(),
          gh<_i5.AuthLocalDataSource>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i15.InjectionModule {}
