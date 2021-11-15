import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/record_page_article_listView.dart';
import 'widget/record_page_button_add_article_component.dart';
import 'widget/record_page_price_panel.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height - 80,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            ListTile(
              title: Text("Achat", 
                style: Theme.of(context)
                  .textTheme
                  .headline5,
              ),
              trailing: RecordPageButtonAddArticleComponent(),
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: RecordPageArticleListView(),
              )
            ),
            Expanded(
              child: RecordPagePricePanel()
            ),
          ],
        ),
      ),
    );
  }
}
