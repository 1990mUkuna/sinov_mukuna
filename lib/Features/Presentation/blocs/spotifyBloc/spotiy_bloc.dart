/* This file acts as a middle man between UI and Data layer, 
Bloc takes an event triggered by the user (ex: SignIn button press, 
SignUp button press, etc) as an input, and responds back to the UI with 
the relevant state.In this, we are going to emit the State according to the Events requested by the user.
Here we also need an AuthRepository for accessing the methods. So initialize it within the constructor. */

import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/spotifyBloc/spotify_event.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/spotifyBloc/spotify_state.dart'; 
import 'package:sinov8_tech_assignment/Features/repositories/spotify_repository.dart';

class SpotifyBloc extends Bloc<SpotifyEvent, SpotifyState> {
  // initialise the repo
  final SpotifyRepository spotifyRepository;
  SpotifyBloc({required this.spotifyRepository}) : super(ArticleNotRequested()) {
    // When User Presses the SignInAnonymously Button,
    on<SpotifyRequested>((event, emit) async {
      emit(Loading());
      try {
        await spotifyRepository.fetchAccessToken(event.genre);
        emit(ArticleRequested());
      } catch (e) {
        emit(ArticleRequestedError(e.toString()));
        emit(ArticleNotRequested());
      }
    });

     

   
  
  }
}
