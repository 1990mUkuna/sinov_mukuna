import 'package:flutter/material.dart';

import '../../../../const.dart';

class ArtistDetailsPage extends StatelessWidget {
  final String artistName;
  final List<String> genres;

  const ArtistDetailsPage(
      {Key? key, required this.artistName, required this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container buildGenreContainer(String genre) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          genre,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    ListView buildGenreListView(List<String> genres) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return buildGenreContainer(genre);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Details'),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/images/spotify-logo.png",
                height: 100,
                width: 100,
              ),
            ),
            sizeVer(100),
            Text(
              artistName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Genres:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            buildGenreListView(genres),
          ],
        ),
      ),
    );
  }
}
