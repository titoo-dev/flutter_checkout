import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/main_page_newRecord_component.dart';
import 'widget/main_page_recent_component.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Flexible(flex: 1, child: MainPageNewRecordComponent()),
            Expanded(flex: 2, child: MainPageRecentComponent())
          ],
        ),
      ),
    );
  }
}
