import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParamsEntity> {
  final UserRepository _userRepository;

  SignUpUseCase(this._userRepository);

  @override
  Future<UserEntity> call({SignUpParamsEntity? params}) async {
    if (params == null) {
      throw ArgumentError('SignUpParamsEntity cannot be null');
    }
    UserEntity userEntity = await _userRepository.signUp(
      email: params.email,
      password: params.password, name: params.name,
    );
    return userEntity;
  }
}
