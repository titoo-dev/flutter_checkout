import 'package:application_caisse/src/controller/page_controller.dart';
import 'package:flutter/material.dart';

class MainPageNewRecordComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      subtitle: Text("Effectuer des achats"),
      title: Text("Nouvel enregistrement"),
      trailing: FloatingActionButton(
          elevation: 1,
          mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            CustomPageController.to.switchPage(1);
          }),
    ));
  }
}
