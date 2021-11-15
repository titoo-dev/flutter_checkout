import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/controller/app_controller.dart';
import 'src/controller/page_controller.dart';
import 'src/controller/record_controller.dart';
import 'src/controller/story_controller.dart';
import 'src/repository/repository.dart';
import 'src/view/main_page/main_page.dart';
import 'src/view/main_page/widget/main_page_drawer.dart';
import 'src/view/record_page/record_page.dart';

void main() async {
  runApp(GetMaterialApp(
    home: Dashboard(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    onInit: () {
      Get.put(AppController());
      Get.put(Repository());
      Get.put(CustomPageController());
      Get.put(RecordController());
      Get.put(StoryController());
    },
  ));
}

class Dashboard extends StatelessWidget {
  final _pages = [MainPage(), RecordPage()];

  Dashboard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: MyDrawer()),
      appBar: AppBar(
        title: const Text("Caisse"),
        actions: [
          IconButton(
            onPressed: () {
              AppController.to.goToPage("hist");
            },
            icon: const Icon(Icons.access_time),
          )
        ],
      ),
      body: FutureBuilder<bool>(
        future: Repository.to.initDb(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GetBuilder<CustomPageController>(
              id: "page", builder: (state) => this._pages[state.currentPage]);
        },
      ),
    );
  }
}
