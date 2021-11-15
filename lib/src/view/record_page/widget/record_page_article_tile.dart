import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final int index;
  final String title;
  final int subtitle;
  final int count;
  ArticleTile({
    this.index,
    this.count, 
    this.subtitle, 
    this.title
  });
  @override
  Widget build(BuildContext context) {
    return ListTile( 
      dense: true,
      subtitle: Text("prix: $subtitle ar"),
      title: Text(this.title),
      trailing: Container(
        width: 130,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 16,
              icon: Icon(Icons.remove), 
              onPressed: (){
                RecordController.to.decrementArticleCount(index);
              }
            ),

            SizedBox(width: 8,),

            Text(this.count.toString()),

            SizedBox(width: 8,),

            IconButton(
              iconSize: 16,
              icon: Icon(Icons.add), 
              onPressed: (){
                RecordController.to.incrementArticleCount(index);
              }
            ),
          ],
        ),
      ),
    );
  }
}