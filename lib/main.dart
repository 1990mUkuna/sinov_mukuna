
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_bloc.dart';
import 'package:sinov8_tech_assignment/Features/repositories/auth_repository.dart';

import 'Features/Presentation/blocs/spotifyBloc/spotiy_bloc.dart';
import 'Features/Presentation/pages/splash_screen.dart';
import 'Features/models/spotify/artist_model.dart';
import 'Features/models/users/user_model.dart';
import 'Features/repositories/spotify_repository.dart';
import 'on_generate_route.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter for the UserModel class
  Hive.registerAdapter<UserModel>(
    UserModelAdapter(),
  );
  Hive.registerAdapter<ArtistModel>(
    ArtistModelAdapter(),
  );

  // function will initialize the Firebase app in our application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        // Add additional repositories
        RepositoryProvider<SpotifyRepository>(
          create: (context) => SpotifyRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
            ),
            BlocProvider<SpotifyBloc>(
              create: (context) => SpotifyBloc(
                spotifyRepository:
                    RepositoryProvider.of<SpotifyRepository>(context),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            onGenerateRoute: OnGenerateRoute.route,
            initialRoute: "/",
            routes: {
              "/": (context) {
                return const SplashScreen();
              }
            },
          )),
    );
  }
}
