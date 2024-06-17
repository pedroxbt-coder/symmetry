import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/get_user.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_event.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_state.dart';

class LocalUserBloc extends Bloc<LocalUserEvent, LocalUserState> {
  final GetUserUseCase _getUserUseCase;

  LocalUserBloc(this._getUserUseCase) : super(const LocalUserLoading()) {
    on<GetUser>(onGetUser);
  }

  void onGetUser(GetUser event, Emitter<LocalUserState> emit) async {
    emit(const LocalUserLoading());
    final user = await _getUserUseCase.call();
    if (user == null) {
      return null;
    }
    emit(LocalUserDone(user));
  }
}
