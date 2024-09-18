import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/shared/bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadingSplash() {
    Future.delayed(const Duration(seconds: 1), () {
      BlocProvider.of<AuthBloc>(context).add(IsLoginEvent());
    });
  }

  @override
  void initState() {
    loadingSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          context.goNamed(RouteName().home);
        } else {
          context.goNamed(RouteName().login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
