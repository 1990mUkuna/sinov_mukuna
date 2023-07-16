/* This file acts as a middle man between UI and Data layer, 
Bloc takes an event triggered by the user (ex: SignIn button press, 
SignUp button press, etc) as an input, and responds back to the UI with 
the relevant state.In this, we are going to emit the State according to the Events requested by the user.
Here we also need an AuthRepository for accessing the methods. So initialize it within the constructor. */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_event.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_state.dart';
import 'package:sinov8_tech_assignment/Features/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // initialise the repo
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // When User Presses the SignInAnonymously Button,
    on<SignInAnonymouslyRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInAnonymously();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    //  Update user Profile
    on<UpdateProfileRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.updateProfile(
            uid: event.uid, userName: event.userName);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
    
  }
}
