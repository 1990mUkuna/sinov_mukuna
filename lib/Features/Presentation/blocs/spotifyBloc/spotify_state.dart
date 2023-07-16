import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; 

@immutable
abstract class SpotifyState extends Equatable {}

 class Loading extends SpotifyState {
  @override
  List<Object?> get props => [];
}


class ArticleRequested extends SpotifyState {
  @override
  List<Object?> get props => [];
}

 class ArticleNotRequested extends SpotifyState {
  @override
  List<Object?> get props => [];
}
 
class ArticleRequestedError extends SpotifyState {
  final String error;

  ArticleRequestedError(this.error);
  @override
  List<Object?> get props => [error];
}
