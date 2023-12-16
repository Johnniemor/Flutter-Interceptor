import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/core/constant/key/key_constant.dart';
import 'package:app_interceptor_rt/features/home_screen.dart';
import 'package:app_interceptor_rt/features/login/presentation/cubit/auth_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_screen.dart';

@RoutePage()
class CheckAuthScreen extends StatelessWidget implements AutoRouteWrapper {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    Future<StatelessWidget> checkUser() async {
      const secure = FlutterSecureStorage();
      final accessToken = await secure.read(key: KeyConstants.accessToken) ?? "";
      if (accessToken != "") {
        return BlocProvider(create: (context) => getIt<AuthCubit>(), child: const HomeScreen());
      } else {
        return BlocProvider(create: (context) => getIt<AuthCubit>(), child: LoginScreen());
      }
    }

    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: FutureBuilder(
        future: checkUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data;
          } else {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
