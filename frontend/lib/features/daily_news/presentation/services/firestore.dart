import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference articles =
      FirebaseFirestore.instance.collection('created articles');

  Future<void> createArticle(String article, String title) {
    return articles.add({
      'title': title,
      'article': article,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getArticlesStream() {
    final articlesStream =
        articles.orderBy('timestamp', descending: true).snapshots();

    return articlesStream;
  }

  Future<void> updateArticle(String docID, String newNote) {
    return articles.doc(docID).update({
      'article': newNote,
      'timestamp': Timestamp.now(),
    });
  }

// Delete
  Future<void> deleteArticle(String docID) async {
    return articles.doc(docID).delete();
  }
}
