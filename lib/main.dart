import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/config/routes/routes.dart';
import 'package:app_interceptor_rt/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


void main() async{
  await configDependencies();
  return runApp(App())
;}


class App extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();
   App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(
          deepLinkBuilder: (_) => const DeepLink([
            PageRouteInfo(CheckAuthRoute.name)
          ]),
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
    );

  }
}