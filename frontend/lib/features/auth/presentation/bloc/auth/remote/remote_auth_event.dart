import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class RemoteAuthEvent {
  final SignUpParamsEntity? signUpParamsEntity;

  const RemoteAuthEvent(this.signUpParamsEntity);
}

class SignUp extends RemoteAuthEvent {
  const SignUp(SignUpParamsEntity signUpParamsEntity): super(signUpParamsEntity);
}
