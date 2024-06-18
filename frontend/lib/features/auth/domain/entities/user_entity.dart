import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photoURL;

  const UserEntity({
    this.id,
    this.email,
    this.name,
    this.photoURL,
  });

  @override
  List<Object?> get props {
    return [id, name, email, photoURL];
  }
}

class SignUpParamsEntity {
  final String name;
  final String email;
  final String password;

  SignUpParamsEntity({
    required this.name,
    required this.email,
    required this.password,
  });
}

// class SignInParamsEntity {
//   final String email;
//   final String password;

//   SignInParamsEntity({
//     required this.email,
//     required this.password,
//   });
// }
