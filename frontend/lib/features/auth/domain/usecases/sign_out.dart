import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final UserRepository _userRepository;

  SignOutUseCase(this._userRepository);

  @override
  Future<void> call({NoParams? params}) async {
    return await _userRepository.signOut();
  }
}

class NoParams {}
