import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../services/firestore.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();
  final int maxChars = 2000;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future publishArticle() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    if (contentController.text.length > maxChars) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Content exceeds maximum character limit')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await firestoreService.createArticle(
        titleController.text, contentController.text);

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article published successfully')),
    );

    titleController.clear();
    contentController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your article"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Write your title here...',
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_image != null) Image.file(_image!),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Attach Image"),
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
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: publishArticle,
                    icon: const Icon(Icons.send),
                    label: const Text("Publish Article"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 70),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
