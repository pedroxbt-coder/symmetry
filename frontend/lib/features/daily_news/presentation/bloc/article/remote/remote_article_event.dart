import '../../../../domain/entities/article.dart';

abstract class RemoteArticlesEvent {
  final ArticleEntity ? article;

  const RemoteArticlesEvent({this.article});
}

class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}

class GetCreatedArticles extends RemoteArticlesEvent {
  const GetCreatedArticles();
}

class CreateArticle extends RemoteArticlesEvent {
  const CreateArticle(ArticleEntity article) : super(article: article);
}

class DeleteMyArticle extends RemoteArticlesEvent {
  const DeleteMyArticle(ArticleEntity article) : super(article: article);
}


