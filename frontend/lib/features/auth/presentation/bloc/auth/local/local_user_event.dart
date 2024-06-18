import '../../../../domain/entities/user_entity.dart';

abstract class LocalUserEvent {
  final UserEntity? userEntity;
  final SignUpParamsEntity? signUpParamsEntity;

  const LocalUserEvent( {this.signUpParamsEntity,this.userEntity});
}

class GetUser extends LocalUserEvent {
  const GetUser();
}

class SignIn extends LocalUserEvent {
  const SignIn(SignUpParamsEntity signUpParamsEntity): super(signUpParamsEntity: signUpParamsEntity);
}

class SignOut extends LocalUserEvent {
  const SignOut();
}