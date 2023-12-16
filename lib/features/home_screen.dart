import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/features/login/presentation/cubit/auth_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Home Page"),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This is Flutter App Interceptor", style: TextStyle( fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
            const Text("You can logout here 👇"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
              child: SizedBox(
                height: 60,
                width: size.width,
                child: ElevatedButton(
                    child: const Text("LogOut"),
                    onPressed: () {
                      context.read<AuthCubit>().logOut();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
