import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/article.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioError? error;
  final FirebaseException? firebaseException;

  const RemoteArticlesState({this.articles, this.error, this.firebaseException});

  @override
  List<Object?> get props => [articles, error, firebaseException];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<ArticleEntity> articles) : super(articles: articles);
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError error) : super(error: error);
}

class CreatedArticlesError extends RemoteArticlesState {
  const CreatedArticlesError(FirebaseException firebaseException) : super(firebaseException: firebaseException);
}