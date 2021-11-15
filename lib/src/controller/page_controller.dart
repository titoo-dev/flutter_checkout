import 'package:get/get.dart';

class CustomPageController extends GetxController {
  static CustomPageController get to => Get.find();

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) => _currentPage = value;

  void switchPage(int newPage) {
    currentPage = newPage;
    update(["page"]);
  }
}
