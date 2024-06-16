import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:floor/floor.dart';

import '../../domain/entities/user_entity.dart';

@Entity(tableName: 'user', primaryKeys: ['id'])
class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? email,
    String? name,
    String? photoURL,
  }) : super(id: id, email: email, name: name, photoURL: photoURL);

  factory UserModel.fromFirebaseUserEntity(firebase_auth.User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      photoURL: photoURL,
    );
  }

  @override
  List<Object?> get props => [id, email, name, photoURL];
}
