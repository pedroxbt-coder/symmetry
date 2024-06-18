import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../models/user_model.dart';

class LocalFirebaseService {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  LocalFirebaseService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<UserModel?> getCurrentUser() async {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return UserModel.fromFirebaseUserEntity(firebaseUser);
  }

  Future<void> leftAccount() async {
    return _firebaseAuth.signOut();
  }

  Future<UserModel?> enterAccount({
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed: The user is null after sign in.');
      }

      return UserModel.fromFirebaseUserEntity(credential.user!);
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }
}
