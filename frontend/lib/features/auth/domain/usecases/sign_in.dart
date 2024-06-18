import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
// import '../repository/auth_repository.dart';

class SignInUseCase implements UseCase<UserEntity?, SignUpParamsEntity> {
  // final UserRepository _userRepository;

  // SignInUseCase(this._userRepository);

  @override
  Future<UserEntity?> call({SignUpParamsEntity? params}) async {
    return null;
  
    // if (params == null) {
    //   throw ArgumentError('SignUpParamsEntity cannot be null');
    // }
    // UserEntity? userEntity = await _userRepository.signIn(
    //     email: params.email, password: params.password, name: params.name);

    // return userEntity;
  }
}
