import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/signup.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';

import '../../../../domain/entities/user_entity.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final SignUpUseCase _signUpUseCase;

  RemoteAuthBloc(this._signUpUseCase) : super(const RemoteAuthLoading()) {
    on<SignUp>(onSignUp);
  }

  void onSignUp(SignUp event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());
    final user =
        await _signUpUseCase(params: event.signUpParamsEntity as SignUpParamsEntity);
    emit(RemoteAuthDone(user));
  }
}
