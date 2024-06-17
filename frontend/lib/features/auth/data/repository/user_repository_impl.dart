import 'package:news_app_clean_architecture/features/auth/data/data_sources/local/local_firebase_service.dart';
import 'package:news_app_clean_architecture/features/auth/data/data_sources/remote/firebase_service.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repository/auth_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseService _firebaseService;
  final LocalFirebaseService _localFirebaseService;
  UserRepositoryImpl(this._firebaseService, this._localFirebaseService);


  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
  }) async {
    final userModel = await _firebaseService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userModel.toEntity();
  }
  
  @override
  Future<UserEntity?> getUser() {
    return _localFirebaseService.getCurrentUser();
  }
}
