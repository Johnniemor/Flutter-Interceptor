import 'package:app_interceptor_rt/config/di/config_dependencies.config.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;


@InjectableInit()
Future<GetIt> configDependencies() async{
  WidgetsFlutterBinding.ensureInitialized();

  return getIt.init();
}