import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/get_user.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/sign_in.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/sign_out.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_event.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_state.dart';

import '../../../../domain/entities/user_entity.dart';

class LocalUserBloc extends Bloc<LocalUserEvent, LocalUserState> {
  final GetUserUseCase _getUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;

  LocalUserBloc(this._getUserUseCase, this._signInUseCase, this._signOutUseCase)
      : super(const LocalUserLoading()) {
    on<GetUser>(onGetUser);
    on<SignIn>(onSignIn);
    on<SignOut>(onSignOut);
  }

  void onGetUser(GetUser event, Emitter<LocalUserState> emit) async {
    emit(const LocalUserLoading());
    final user = await _getUserUseCase.call();
    if (user == null) {
      emit(LocalUserError(FirebaseAuthException(
        code: 'USER_NOT_FOUND',
        message: 'User not found',
      )));
      return;
    }
    emit(LocalUserDone(user));
  }

  void onSignIn(SignIn event, Emitter<LocalUserState> emit) async {
    emit(const LocalUserLoading());
    final user = await _signInUseCase(
        params: event.signUpParamsEntity as SignUpParamsEntity);
    if (user == null) {
      emit(LocalUserError(FirebaseAuthException(
        code: 'SIGN_IN_FAILED',
        message: 'Sign in failed',
      )));
      return;
    }
    emit(LocalUserDone(user));
  }

  void onSignOut(SignOut event, Emitter<LocalUserState> emit) async {
    await _signOutUseCase();
    emit(const LocalUserLoading());
  }
}
