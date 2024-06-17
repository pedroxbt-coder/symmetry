import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/usecase/usecase.dart';

class GetUserUseCase implements UseCase<UserEntity?, void> {
  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  @override
  Future<UserEntity?> call({void params}) async {
    return _userRepository.getUser();
  }
}
