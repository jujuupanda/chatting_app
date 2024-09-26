import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/general_widgets/button_positive.dart';
import '../../../../core/general_widgets/custom_loading.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/services/parsing_date.dart';
import '../../../../core/shared/bloc/auth/auth_bloc.dart';
import '../manager/profile_bloc.dart';
import '../widgets/profile_information_card_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  getProfile() {
    BlocProvider.of<ProfileBloc>(context).add(GetProfile());
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.goNamed(RouteName().login);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 56),
          child: AppBar(
            title: const Text("Profil"),
            titleTextStyle: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is GetProfileSuccess) {
                        final profile = state.profile;
                        return Column(
                          children: [
                            ProfileInformationCardView(
                              onTap: () {},
                              title: "Nama",
                              information: ParsingString().formatFullName(
                                  "${profile.firstName} ${profile.middleName} ${profile.lastName}"),
                              iconData: Icons.person_outline,
                            ),
                            const Divider(height: 1, thickness: 1),
                            ProfileInformationCardView(
                              onTap: () {},
                              title: "Email",
                              information: profile.email,
                              iconData: Icons.email_outlined,
                            ),
                            const Divider(height: 1, thickness: 1),
                            ProfileInformationCardView(
                              onTap: () {},
                              title: "Telepon",
                              information: profile.phone,
                              iconData: Icons.phone_outlined,
                            ),
                            const Divider(height: 1, thickness: 1),
                            ProfileInformationCardView(
                              onTap: () {},
                              title: "Info",
                              information: profile.information,
                              iconData: Icons.info_outline,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  ButtonPositive(
                    name: "Logout",
                    width: 140,
                    function: () {
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    },
                  ),
                ],
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
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const CustomLoading();
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
