import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class RemoteAuthState extends Equatable {
  final UserEntity? userEntity;
  final FirebaseException? firebaseException;

  const RemoteAuthState({this.userEntity, this.firebaseException});

  @override
  List<Object?> get props => [userEntity, firebaseException];
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone(UserEntity userEntity) : super(userEntity: userEntity);
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError(FirebaseException firebaseException)
      : super(firebaseException: firebaseException);
}
