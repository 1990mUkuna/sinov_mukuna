import 'package:flutter/material.dart';

class ArtistDetailsPage extends StatelessWidget {
  final String artistName;

  const ArtistDetailsPage({Key? key, required this.artistName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Details'),
      ),
      body:  Container(
         height: double.infinity,
        child: Column(
          children: [
            Image.asset(
              "assets/images/spotify-logo.png",
              height: 60,
              width: 60,
            ),
            Text(
              artistName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
