import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/delete_my_article.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/create_article.dart';
import '../../../../domain/usecases/get_article.dart';
import '../../../../domain/usecases/get_created_articles.dart';
import 'remote_article_event.dart';
import 'remote_article_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;
  final CreateArticleUseCase _createArticleUseCase;
  final GetCreatedArticleUseCase _getCreatedArticleUseCase;
  final DeleteMyArticleUseCase _deleteMyArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase, this._createArticleUseCase,
      this._getCreatedArticleUseCase, this._deleteMyArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
    on<CreateArticle>(onCreateArticle);
    on<GetCreatedArticles>(onGetCreatedArticles);
    on<DeleteMyArticle>(onDeleteMyArticle);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticlesState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }

  void onCreateArticle(
      CreateArticle createArticle, Emitter<RemoteArticlesState> emit) async {
    await _createArticleUseCase(params: createArticle.article);
  }

  void onGetCreatedArticles(
      GetCreatedArticles event, Emitter<RemoteArticlesState> emit) async {
    final articles = await _getCreatedArticleUseCase();
    emit(RemoteArticlesDone(articles));
  }

  void onDeleteMyArticle(DeleteMyArticle deleteMyArticle,
      Emitter<RemoteArticlesState> emit) async {
        
    await _deleteMyArticleUseCase(params: deleteMyArticle.article);
    final articles = await _getCreatedArticleUseCase();
    emit(RemoteArticlesDone(articles));
  }
}
