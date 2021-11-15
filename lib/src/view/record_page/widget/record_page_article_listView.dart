import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'record_page_article_tile.dart';

class RecordPageArticleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordController>(
      id: "record_listView",
      builder: (state) {
        if(state.articles.isEmpty){
          return Center(child: Text("Pas de produit", 
            style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(
                color: Colors.grey[400]
              )
          ),);
        }
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return Dismissible(
              direction: DismissDirection.startToEnd,
              onDismissed: (direction){
                if(direction == DismissDirection.startToEnd){
                  state.removeArticleToList(index);
                }
              },
              background: Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white70,)
                    ],
                  ),
                ),
              ),
              key: UniqueKey(), 
              child: ArticleTile(
                index: index,
                title: state.articles[index].name,
                count: state.articles[index].count,
                subtitle: state.articles[index].totalPrice,
              )
            );
          }, 
          separatorBuilder: (context, i){
            return Divider();
          }, 
          itemCount: state.articles.length
        );
      }
    );
  }
}