import '../../../../domain/entities/user_entity.dart';

abstract class LocalUserEvent {}

class GetUser extends LocalUserEvent {
  final UserEntity? userEntity;

  GetUser({this.userEntity});
}
