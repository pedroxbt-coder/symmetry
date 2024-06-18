import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/bloc/auth/local/local_user_state.dart';
import '../../../domain/entities/article.dart';
import '../../widgets/app_bar_items.dart';
import '../../widgets/article_tile.dart';
import '../../widgets/user_name.dart';

class DailyNews extends HookWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticlesBloc = useMemoized(() => sl<RemoteArticlesBloc>());

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

    return BlocProvider(
      create: (_) => remoteArticlesBloc,
      child: BlocListener<LocalUserBloc, LocalUserState>(
        listener: (context, state) {
          if (state is LocalUserDone) {
            reFetchArticles();
          }
        },
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
          floatingActionButton: BlocBuilder<LocalUserBloc, LocalUserState>(
            builder: (context, state) {
              if (state is LocalUserDone && state.user.email != null) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/CreateArticle');
                  },
                  child: const Icon(Icons.add),
                );
              } else {
                return FloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'You must be authenticated to publish an article.'),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          UserNameWidget(),
          SizedBox(width: 10),
          Text(
            'Daily News',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      actions: [
        BlocBuilder<LocalUserBloc, LocalUserState>(
          builder: (context, state) {
            if (state is LocalUserDone && state.user.email != null) {
              return AppBarItems(user: true, context: context);
            } else {
              return AppBarItems(user: false, context: context);
            }
          },
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

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
