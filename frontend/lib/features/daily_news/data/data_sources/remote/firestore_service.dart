import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';

class FirestoreService {
  final CollectionReference articles = 
      FirebaseFirestore.instance.collection('created articles');

  Future<void> postArticle(ArticleModel article) {
    return articles.add({
      'author': article.author!,
      'title': article.title,
      'description': article.description,
      'url_to_image': article.urlToImage!,
      'published_at': article.publishedAt!,
      'content': article.content!,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteCreatedArticle(ArticleModel article) async {
    return articles.doc(article.id.toString()).delete();
  }

  Future<List<ArticleModel>> getArticles() async {
    final snapshot = await articles.orderBy('timestamp', descending: true).get();
    return snapshot.docs
        .map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ArticleModel.fromMap({
        'id': doc.id,
        ...data,
      });
    }).toList();
  }

  Stream<QuerySnapshot> getArticlesStream() {
    return articles.orderBy('timestamp', descending: true).snapshots();
  }


}



