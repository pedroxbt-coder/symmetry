import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class FirebaseService {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    firebase_auth.UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

    if (credential.user == null) {
      throw Exception('Sign up failed: The user is null after sign up.');
    }

    return UserModel.fromFirebaseUserEntity(credential.user!);
  }
}
