import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../models/users/user_model.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInAnonymously() async {
    try {
      final anonyObject = await FirebaseAuth.instance.signInAnonymously();

      // Get the user UID
      final String uid = anonyObject.user!.uid;
      // Get the anonymous sign-in status
      final bool isAnonymous = anonyObject.user!.isAnonymous;

      // Create a user document in the Firestore "users" collection
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'isAnonymous': isAnonymous,
        'userId': uid,
        // Set any additional user data here
      });

      // Create a UserModel instance
      final userModel = UserModel(
          uid: uid,
          email: '', // Set the email value if applicable
          username: '', // Set the username value if applicable
          isAnonymous: isAnonymous,
          spotifyHeadertoken: '');

      // Store the UserModel instance in Hive
      final box = await Hive.openBox('userBox');
      await box.put('user', userModel);
      await box.close();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

Future<void> updateProfile({required String uid, required String userName}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'userName': userName});

    // Update the username in Hive
    final box = await Hive.openBox('userBox');
    final UserModel? userModel = box.get('user') as UserModel?;
    if (userModel != null) {
      final updatedUserModel = UserModel(
        uid: userModel.uid,
        email: userModel.email,
        username: userName, // Update the username here
        isAnonymous: userModel.isAnonymous,
        spotifyHeadertoken: userModel.spotifyHeadertoken,
      );
      await box.put('user', updatedUserModel);
    }
    await box.close();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'anonymous-user-not-found') {
      throw Exception('No anonymous user found for that uid.');
    } else if (e.code == 'wrong-uid') {
      throw Exception('Wrong uid provided for that user.');
    }
  }
}

Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
