import 'package:flutter/material.dart';

class ArtistDetailsPage extends StatelessWidget {
  final String artistName;

  const ArtistDetailsPage({Key? key, required this.artistName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artistName),
      ),
      body: Container(
          // Add artist details UI here
          ),
    );
  }
}
