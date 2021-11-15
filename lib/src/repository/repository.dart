import 'package:application_caisse/src/model/article_for_listing.dart';
import 'package:application_caisse/src/model/purshase.dart';

import '../persistance/db.dart';
import 'package:get/get.dart';

class Repository extends GetxController {
  final Db db = Db();

  Future<bool> initDb() {
    return db.asyncInit();
  }

  Future<List<ArticleForListing>> getArticles() {
    return db.getArticles();
  }

  Future<int> addArticle(ArticleForListing article) async {
    return await db.addArticle(article);
  }

  Future<void> addPurshase(Purshase purshase) {
    return db.addPurshase(purshase);
  }

  Future<void> updateArticle(ArticleForListing newArticle) {
    return db.updateArticle(newArticle);
  }

  Future<void> deleteArticle(int id) {
    return db.deleteArticle(id);
  }

  List<ArticleForListing> getArticlesList() {
    return db.articles;
  }

  static Repository get to => Get.find();
}
