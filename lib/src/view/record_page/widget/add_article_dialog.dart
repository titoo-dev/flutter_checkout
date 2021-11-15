import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:application_caisse/src/model/article_for_listing.dart';
import 'package:application_caisse/src/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddArticleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: Get.height / 6,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (text) {
                        RecordController.to.validateArticleName();
                      },
                      controller: RecordController.to.nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: "Nom",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey[500])),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GetBuilder<RecordController>(
                          id: "add_name_button",
                          builder: (state) => FlatButton(
                              color: state.articleNameIsValidated
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                              textColor: state.articleNameIsValidated
                                  ? Colors.white
                                  : Colors.black38,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              onPressed: state.articleNameIsValidated
                                  ? () {
                                      Get.back(canPop: true, result: true);
                                    }
                                  : () => {},
                              child: Text("ajouter".toUpperCase())),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: Get.height / 3,
          child: FutureBuilder<List<ArticleForListing>>(
              future: Repository.to.getArticles(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Chargement...",
                        style: Theme.of(context).textTheme.caption),
                  );
                } else if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text("Pas de produit disponible",
                        style: Theme.of(context).textTheme.caption),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Wrap(
                      spacing: 8,
                      children: snapshot.data
                          .map((article) => ActionChip(
                                onPressed: () {
                                  RecordController.to
                                      .setCurrentArticle(article);
                                },
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                label: Text(article.name),
                              ))
                          .toList()),
                );
              }),
        ),
      ],
    );
  }
}
