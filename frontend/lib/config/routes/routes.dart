import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/create_article/create_article.dart';

import '../../features/auth/presentation/pages/sign_in/sign_in.dart';
import '../../features/auth/presentation/pages/sign_up/sign_up.dart';
import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/my_articles/my_articles.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());
      case '/CreateArticle':
        return _materialRoute(const PostArticle());
      case '/MyArticles':
        return _materialRoute(const MyArticles());
      case '/LogIn':
        return _materialRoute(SignInPage());
      case '/SignUp':
        return _materialRoute(SignUpPage());

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
