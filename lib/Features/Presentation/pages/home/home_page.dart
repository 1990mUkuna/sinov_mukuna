import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/blocs/spotifyBloc/spotify_event.dart';
import 'package:sinov8_tech_assignment/Features/Presentation/pages/artist/artist_details.dart';
import 'package:sinov8_tech_assignment/Features/models/spotify/artist_model.dart';
import 'package:sinov8_tech_assignment/Features/widgets/modal_popup_search_genre.dart';

import '../../../../const.dart';
import '../../../models/users/user_model.dart';
import '../../../widgets/modal_popup_form.dart';
import '../../blocs/spotifyBloc/spotify_state.dart';
import '../../blocs/spotifyBloc/spotiy_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UserModel?> _getUserModel;
  final TextEditingController _textFieldGenreController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<UserModel?> _getData() async {
    final box = await Hive.openBox('userBox');
    final userModel = box.get('user') as UserModel?;
    await box.close();
    return userModel;
  }

  List<ArtistModel> artistList = [];

  @override
  void initState() {
    super.initState();
    _getUserModel = _getData();
    _loadArtistList();
  }

  @override
  void dispose() {
    _textFieldGenreController.dispose();
    super.dispose();
  }

  void _searchGenre() {
    _showModalPopup(context);
  }

  Future<void> _loadArtistList() async {
    final box = await Hive.openBox('artistBox');
    final List<dynamic> artistListData = box.get('artist', defaultValue: []);
    setState(() {
      artistList = artistListData.cast<ArtistModel>();
    });
    await box.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable back button functionality
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          automaticallyImplyLeading: false, // Hide the back arrow
        ),
        body: FutureBuilder<UserModel?>(
          future: _getUserModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final UserModel? storedUserModel = snapshot.data;

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _searchGenre,
                      child: const Text('Search new genre'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Welcome : ${storedUserModel?.username ?? "Unknown"}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: GridView.custom(
                        gridDelegate: SliverWovenGridDelegate.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          pattern: [
                            const WovenGridTile(1),
                            const WovenGridTile(
                              5 / 7,
                              crossAxisRatio: 0.9,
                              alignment: AlignmentDirectional.centerEnd,
                            ),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final artist = artistList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArtistDetailsPage(
                                        artistName: artist.name),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    /* if (artist.images.isNotEmpty &&
                                        artist.images.first is Map)
                                      Image.network(
                                        (artist.images.first as Map)['url'],
                                        fit: BoxFit.cover,
                                      ), */
                                    Image.asset(
                                      "assets/images/spotify-logo.png",
                                      height: 60,
                                      width: 60,
                                    ),
                                    // Ot
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        artist.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        artist.genres.join(', '),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: artistList.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showModalPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Set barrierDismissible to false
      builder: (BuildContext context) {
        return const ModalPopupSearchGenre();
      },
    );
  }
}
