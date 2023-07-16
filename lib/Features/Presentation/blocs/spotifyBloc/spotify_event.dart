import 'package:equatable/equatable.dart';

abstract class SpotifyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SpotifyRequested extends SpotifyEvent {
  final String genre;
  SpotifyRequested(this.genre);
}
