import 'package:flutter/material.dart';

import '../../controller/app_controller.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètre"),
        leading: IconButton(
          onPressed: (){
            AppController.to.goBack();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Thème de l'Application"),
            trailing: IconButton(
              onPressed: (){
                AppController.to.showColors();
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}