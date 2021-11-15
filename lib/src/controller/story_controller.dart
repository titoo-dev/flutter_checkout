import 'package:application_caisse/src/model/article_for_listing.dart';
import 'package:application_caisse/src/repository/repository.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  List<ArticleForListing> art = Repository.to.getArticlesList().obs;
  static StoryController get to => Get.find();

  @override
  void onReady() {
    this.getStoryData();
  }

  void getStoryData() {
    art = Repository.to.getArticlesList();
    //update();
  }
}
