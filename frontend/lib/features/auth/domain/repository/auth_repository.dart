import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> signUp({
    required String email,
    required String password,
  });

  Future<UserEntity?> getUser();
}
