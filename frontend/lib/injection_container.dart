import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/auth/data/data_sources/local/local_firebase_service.dart';
import 'package:news_app_clean_architecture/features/auth/data/data_sources/remote/firebase_service.dart';
import 'package:news_app_clean_architecture/features/auth/data/repository/user_repository_impl.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/get_user.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/sign_in.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/sign_out.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/sign_up.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/create_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/delete_my_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_created_articles.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/data/data_sources/remote/firestore_service.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<FirestoreService>(FirestoreService());

  sl.registerSingleton<FirebaseService>(FirebaseService());
  sl.registerSingleton<LocalFirebaseService>(LocalFirebaseService());

  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(sl(), sl(), sl()));

  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl(), sl()));

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  //firestore usecases
  sl.registerSingleton<CreateArticleUseCase>(CreateArticleUseCase(sl()));

  sl.registerSingleton<GetCreatedArticleUseCase>(
      GetCreatedArticleUseCase(sl()));

  sl.registerSingleton<DeleteMyArticleUseCase>(DeleteMyArticleUseCase(sl()));
  //firebase usecases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));

  sl.registerFactory<RemoteAuthBloc>(() => RemoteAuthBloc(sl()));

  sl.registerFactory<LocalUserBloc>(() => LocalUserBloc(sl(), sl(), sl()));
}
