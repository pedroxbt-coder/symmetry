import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';

class PostArticle extends StatefulWidget {
  const PostArticle({super.key});

  @override
  State<PostArticle> createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void publishArticle(BuildContext context) {
    String? errorMessage = titleController.text.isEmpty
        ? 'Title cannot be empty'
        : contentController.text.isEmpty
            ? 'Content field cannot be empty'
            : contentController.text.length > 2000
                ? 'Content exceeds maximum character limit'
                : null;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    var article = ArticleEntity(
      author: 'Your Author Name', //todo: user.username
      title: titleController.text,
      description: contentController.text,
      urlToImage: 'https://dims.apnews.com/dims4/default/30da2ad/2147483647/strip/true/crop/7382x4152+0+384/resize/1440x810!/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F05%2F00%2F3b8fda9ca5321a2168875a3ecda2%2F32707c6251c341e0ab89a71b98c01c2b',
      publishedAt: DateTime.now().toIso8601String(),
      content: contentController.text,
    );

    context.read<RemoteArticlesBloc>().add(CreateArticle(article));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article published successfully')),
    );

    titleController.clear();
    contentController.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/daily_news', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your article"),
        leading: Builder(
          builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Write your title here...',
                  labelText: 'Article Title',
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.photo),
                label: const Text("Attach Image"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Add article here...',
                  labelText: 'Article Content',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => publishArticle(context),
                icon: const Icon(Icons.send),
                label: const Text("Publish Article"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
