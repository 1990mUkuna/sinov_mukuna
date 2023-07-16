import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final bool isAnonymous;
  @HiveField(4)
  final String spotifyHeadertoken;

  const UserModel(
      {required this.uid,
      required this.email,
      required this.username,
      required this.isAnonymous,
      required this.spotifyHeadertoken,
      });

  @override
  List<Object?> get props => [uid, email, username, spotifyHeadertoken];
}
