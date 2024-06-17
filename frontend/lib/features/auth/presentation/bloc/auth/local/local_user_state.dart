import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class LocalUserState {
  final FirebaseAuthException? firebaseAuthException;

  const LocalUserState({this.firebaseAuthException});
}

class LocalUserLoading extends LocalUserState {
  const LocalUserLoading() : super(firebaseAuthException: null);
}

class LocalUserDone extends LocalUserState {
  final UserEntity user;

  const LocalUserDone(this.user) : super(firebaseAuthException: null);
}

class LocalUserError extends LocalUserState {
  final FirebaseAuthException exception;

  const LocalUserError(this.exception) : super(firebaseAuthException: exception);
}
