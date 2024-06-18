import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<UserEntity?> getUser();

  Future<void> signOut();

  // Future<UserEntity?> signIn({
  //   required String email,
  //   required String password,
  // });
}
