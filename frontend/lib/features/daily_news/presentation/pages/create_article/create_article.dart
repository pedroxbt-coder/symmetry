import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/bloc/auth/local/local_user_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';

class PostArticle extends StatefulWidget {
  const PostArticle({Key? key}) : super(key: key);

  @override
  State<PostArticle> createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  String? _pickedImagePath;

  void publishArticle(BuildContext context, String? authorName) {
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
      author: authorName,
      title: titleController.text,
      description: contentController.text,
      urlToImage: _pickedImagePath ?? '',
      publishedAt: DateTime.now().toIso8601String(),
      content: contentController.text,
    );

    context.read<RemoteArticlesBloc>().add(CreateArticle(article));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article published successfully')),
    );

    titleController.clear();
    contentController.clear();
    imageUrlController.clear();
    setState(() {
      _pickedImagePath = null;
    });
    Navigator.pushNamedAndRemoveUntil(context, '/daily_news', (route) => false);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImagePath = pickedFile.path;
      });
    }
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
      body: BlocBuilder<LocalUserBloc, LocalUserState>(
        builder: (context, state) {
          if (state is LocalUserDone) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Write your title here...',
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_pickedImagePath != null)
                          Center(
                            child: Image.file(
                              File(_pickedImagePath!),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.photo),
                              label: const Text("Attach Image"),
                            ),
                          ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: contentController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Add article here...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => publishArticle(context, state.user.name),
                      icon: const Icon(Icons.send),
                      label: const Text("Publish Article"),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 24),
                        minimumSize: const Size(double.maxFinite, 70),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
