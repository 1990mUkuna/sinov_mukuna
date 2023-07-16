import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'artist_model.g.dart';

@HiveType(typeId: 2)
class ArtistModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int popularity;
  @HiveField(3)
  final List<String> images;
  @HiveField(4)
  final List<String> genres;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.popularity,
    required this.images,
    required this.genres,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      popularity: json['popularity'] as int,
      images: (json['images'] as List<dynamic>).cast<String>(),
      genres: (json['genres'] as List<dynamic>).cast<String>(),
    );
  }

  @override
  List<Object?> get props => [id, name, popularity, images, genres];
}
