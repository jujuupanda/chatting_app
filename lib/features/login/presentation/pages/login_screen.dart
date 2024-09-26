import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/general_widgets/button_positive.dart';
import '../../../../core/general_widgets/custom_loading.dart';
import '../../../../core/general_widgets/custom_text_form_field.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/shared/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.goNamed(RouteName().home);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(32),
                        child: Icon(
                          Icons.chat,
                          size: 130,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(30),
                    CustomTextFormField(
                      fieldName: "Email",
                      hint: "Alamat Email",
                      controller: emailController,
                      prefixIcon: Icons.email,
                    ),
                    CustomTextFormField(
                      fieldName: "Kata Sandi",
                      hint: "Kata Sandi",
                      controller: passwordController,
                      prefixIcon: Icons.lock,
                    ),
                    const Gap(20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is LoginFailed) {
                          return Text(
                            state.message,
                            style: GoogleFonts.openSans(
                              color: Colors.redAccent,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const Gap(20),
                    ButtonPositive(
                      name: "Login",
                      function: () {
                        if (formState.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CustomLoading();
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

