import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:flutter/material.dart';

class RecordPageButtonAddArticleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ActionChip(
          elevation: 2,
          padding: EdgeInsets.only(left: 4, right: 8),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
          onPressed: (){
            RecordController.to.addArticle();
          },
          avatar: Icon(Icons.add),
          label: Text("Ajouter un produit"),
        )
      )
    );
  }
}