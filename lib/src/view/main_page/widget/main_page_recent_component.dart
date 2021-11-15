import 'package:application_caisse/src/model/article_for_listing.dart';
import 'package:flutter/material.dart';
import '../../../repository/repository.dart';

class MainPageRecentComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text("Achats Recents",
                style: Theme.of(context).textTheme.headline5),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<ArticleForListing>>(
              future: Repository.to.getArticles(),
              builder: (context, snapshot) {
                return (!snapshot.hasData || snapshot.data == null)
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, i) {
                          return Divider();
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            leading: Icon(Icons.shopping_cart_outlined),
                            title: Text("${snapshot.data[index].name}"),
                            subtitle:
                                Text("le ${snapshot.data[index].createdAt}"),
                            trailing: Chip(
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                label: Text("${snapshot.data[index].price}")),
                          );
                        });
              },
            ),
          )
        ],
      ),
    );
  }
}
