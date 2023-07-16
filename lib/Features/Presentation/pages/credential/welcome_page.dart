import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_bloc.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_state.dart';
import 'package:sinov8_tech_assignment/Features/widgets/button_container_widget.dart';
import 'package:sinov8_tech_assignment/Features/widgets/modal_popup_form.dart';
import 'package:sinov8_tech_assignment/const.dart';

import '../../blocs/authBloc/auth_event.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            //Navigator.pushNamed(context, PageConst.mainScreen);
            _showModalPopup(context);
          }

          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Loading) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UnAuthenticated) {
            // Showing all the option to sign in
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sizeVer(50),
                  const Center(child: Text("Logo")),
                  sizeVer(140),
                  ButtonContainerWidget(
                    color: blueColor,
                    text: "Anonymous sign-i",
                    onTapListener: () {
                      _authenticateAnonymous(context);
                    },
                  ),
                  sizeVer(17),
                  ButtonContainerWidget(
                    color: blueColor,
                    text: "Email sign in",
                    onTapListener: () {
                      //  MaterialPageRoute(builder: (context) => const HomePage());
                    },
                  ),
                  sizeVer(17),
                  ButtonContainerWidget(
                    color: blueColor,
                    text: "Google",
                    onTapListener: () {
                      //  MaterialPageRoute(builder: (context) => const HomePage());
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  void _authenticateAnonymous(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignInAnonymouslyRequested(),
    );
  }

  void _showModalPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Set barrierDismissible to false
      builder: (BuildContext context) {
        return const ModalPopupForm();
      },
    );
  }



}
