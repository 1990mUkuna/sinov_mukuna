import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/authBloc/auth_bloc.dart';
import 'package:sinov8_tech_assignment/const.dart';

import '../Presentation/blocs/authBloc/auth_event.dart';
import '../Presentation/blocs/spotifyBloc/spotify_event.dart';
import '../Presentation/blocs/spotifyBloc/spotify_state.dart';
import '../Presentation/blocs/spotifyBloc/spotiy_bloc.dart';
import '../models/users/user_model.dart';

class ModalPopupSearchGenre extends StatefulWidget {
  const ModalPopupSearchGenre({Key? key}) : super(key: key);

  @override
  _ModalPopupSearchGenreState createState() => _ModalPopupSearchGenreState();
}

class _ModalPopupSearchGenreState extends State<ModalPopupSearchGenre> {
  late Future<UserModel?> _getUserModel;
   
  final TextEditingController _textFieldGenreController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getUserModel = _getData();
  }

  @override
  void dispose() {
    
    _textFieldGenreController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Fields are valid, submit the form
      _requestSpotify(context);
      Navigator.of(context).pop();
    }
  }

  Future<UserModel?> _getData() async {
    final box = await Hive.openBox('userBox');
    final userModel = box.get('user') as UserModel?;
    await box.close();
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: _getUserModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final UserModel? storedUserModel = snapshot.data; 
          return AlertDialog(
            title: Column(
              children: [
                Text('Your UID: ${storedUserModel?.uid ?? "Unknown"}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                sizeVer(10),
                const Text(
                  "Search Artist By Genre",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  TextFormField(
                    controller: _textFieldGenreController,
                    decoration: const InputDecoration(
                      labelText: 'Genre e.g: rock',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Genre is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              BlocListener<SpotifyBloc, SpotifyState>(
                listener: (context, state) {
                  if (state is ArticleRequested) {
                    // Navigating to the dashboard screen if the user is authenticated
                    Navigator.pushNamed(context, PageConst.homeScreen);
                  }

                  if (state is ArticleRequestedError) {
                    // Showing the error message if the user has entered invalid credentials
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void _requestSpotify(context) async {
    // Initialize Hive
    await Hive.initFlutter();
    // Open the box
    final box = await Hive.openBox('userBox');
    // Retrieve the user model from the box
    final userModel = box.get('user');
    final uid = userModel.uid;
    // Close the box
    await box.close();
    // Use the uid as needed
    print(uid);
    // Rest of your code...
     
    BlocProvider.of<SpotifyBloc>(context).add(
      SpotifyRequested(_textFieldGenreController.text),
    );
  }
}
