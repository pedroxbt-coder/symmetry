import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class GetCreatedArticleUseCase implements UseCase<List<ArticleEntity>,void>{
  
  final ArticleRepository _articleRepository;

  GetCreatedArticleUseCase(this._articleRepository);
  
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getCreatedArticles();
  }
  
}