import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends HookWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticlesBloc = useMemoized(() => sl<RemoteArticlesBloc>());

    bool user = isAuthenticated();

    void reFetchArticles() {
      remoteArticlesBloc.add(const GetArticles());
    }

    useEffect(() {
      final NavigatorState navigator = Navigator.of(context);
      navigator.popUntil((route) {
        reFetchArticles();
        return true;
      });
      return;
    }, []);

    remoteArticlesBloc.add(const GetArticles());

    return BlocProvider(
      create: (_) => remoteArticlesBloc,
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
          builder: (context, state) {
            if (state is RemoteArticlesLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is RemoteArticlesError) {
              return const Center(child: Icon(Icons.refresh));
            } else if (state is RemoteArticlesDone) {
              return _buildArticlesPage(context, state.articles!);
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (user) {
              Navigator.pushNamed(context, '/CreateArticle');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('You must have an account to publish articles.'),
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  bool isAuthenticated() {
    return false;
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    bool user = isAuthenticated();
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: user
          ? [
              GestureDetector(
                onTap: () => _onShowSavedArticlesViewTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.bookmark, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () => _onShowMyArticlesViewTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.article, color: Colors.black),
                ),
              ),
            ]
          : [
              GestureDetector(
                onTap: () => _onLoginTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.login, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () => _onSignupTapped(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.app_registration, color: Colors.black),
                ),
              ),
            ],
    );
  }

  Widget _buildArticlesPage(
      BuildContext context, List<ArticleEntity> articles) {
    return ListView(
      children: articles.map((article) {
        return ArticleWidget(
          article: article,
          onArticlePressed: (article) => _onArticlePressed(context, article),
        );
      }).toList(),
    );
  }

  void _onLoginTapped(BuildContext context) {
    Navigator.pushNamed(context, '/LogIn');
  }

  void _onSignupTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SignUp');
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }

  void _onShowMyArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/MyArticles');
  }
}
