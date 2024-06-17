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
}
