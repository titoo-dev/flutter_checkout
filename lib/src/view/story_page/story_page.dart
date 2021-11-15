import 'package:flutter/material.dart';
import 'package:application_caisse/src/model/article_for_listing.dart';
import '../../repository/repository.dart';
import '../../controller/app_controller.dart';

class StoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique"),
        leading: IconButton(
          onPressed: () {
            AppController.to.goBack();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<ArticleForListing>>(
            future: Repository.to.getArticles(),
            builder: (context, snapshot) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, i) {
                    return Divider();
                  },
                  itemCount: art.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      leading: Icon(Icons.shopping_cart_outlined),
                      title: Text(
                          "${snapshot.data[index].name}\t\t\t X${snapshot.data[index].count}"),
                      subtitle: Text("le ${snapshot.data[index].createdAt}"),
                      trailing: Chip(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          label: Text(
                              "${snapshot.data[index].price * snapshot.data[index].count}")),
                    );
                  });
            }),
      ),
    );
  }
}

List<ArticleForListing> art = Repository.to.getArticlesList();
