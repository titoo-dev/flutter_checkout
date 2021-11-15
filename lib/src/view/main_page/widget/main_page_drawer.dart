import 'package:application_caisse/src/controller/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/app_controller.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 80),
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Text(
              "Société X",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryIconTheme.color,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: GetBuilder<AppController>(
            id: "drawer",
            builder: (state) => ListView(
              padding: EdgeInsets.all(0),
              children: [
                ListTile(
                  onTap: () {
                    CustomPageController.to.switchPage(0);
                    Get.back();
                  },
                  tileColor: state.currentpage == "main"
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  leading: Icon(Icons.home),
                  title: Text("Accueil"),
                ),
                ListTile(
                  tileColor: state.currentpage == "params"
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  onTap: () {
                    state.goToPage("params");
                  },
                  leading: Icon(Icons.settings),
                  title: Text("Paramètres"),
                ),
                ListTile(
                  tileColor: state.currentpage == "hist"
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  onTap: () {
                    state.goToPage("hist");
                  },
                  leading: Icon(Icons.access_time),
                  title: Text("Historique"),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
