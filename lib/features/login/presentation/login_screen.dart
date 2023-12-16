import 'package:app_interceptor_rt/config/di/config_dependencies.dart';
import 'package:app_interceptor_rt/config/routes/routes.dart';
import 'package:app_interceptor_rt/config/routes/routes.gr.dart';
import 'package:app_interceptor_rt/features/login/presentation/cubit/auth_cubit.dart';
import 'package:app_interceptor_rt/features/login/presentation/widget/custom_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget implements AutoRouteWrapper {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {
              // TDO : Loading Functions...
            },
            sucess: (authEntity) =>
                getIt<AppRouter>().replaceAll([const HomeRoute()]),
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "User login failed",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                backgroundColor: Colors.white,
              ));
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Flutter Interceptor",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                          hintText: 'Enter your username',
                          obsecureText: false,
                          controller: usernameController),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                          hintText: 'Password',
                          obsecureText: true,
                          controller: passwordController),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 60,
                        width: size.width,
                        child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: () {
                            if (_formKey.currentState!.validate() != false) {
                              final username = usernameController.text.trim();
                              final password = passwordController.text.trim();
                              // getIt<AuthCubit>().login(username, password);
                              context
                                  .read<AuthCubit>()
                                  .login(username, password);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
