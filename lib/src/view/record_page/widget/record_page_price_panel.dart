import 'package:application_caisse/src/controller/app_controller.dart';
import 'package:application_caisse/src/controller/story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/record_controller.dart';

class RecordPagePricePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 0.0),
            blurRadius: 5,
            spreadRadius: 1)
      ]),
      child: PageView(
        children: [
          Panel(),
          SecondPanel(),
        ],
      ),
    );
  }
}

class SecondPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
                child: FlatButton.icon(
              icon: Icon(Icons.print),
              color: Theme.of(context).primaryColor,
              minWidth: Get.width,
              height: Get.height / 2,
              onPressed: AppController.to.printData,
              textColor: Colors.white,
              label: Text("Imprimer".toUpperCase()),
            )),
          ),
          Flexible(
            flex: 1,
            child: Container(
                child: FlatButton.icon(
              icon: Icon(Icons.save_alt),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              minWidth: Get.width,
              height: Get.height / 2,
              onPressed: () {
                RecordController.to.savePurshase();
                StoryController.to.getStoryData();
              },
              label: Text("enregistrer".toUpperCase()),
            )),
          ),
        ],
      ),
    );
  }
}

class Panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(right: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                      dense: true,
                      title: Text(
                        "Total:",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: GetBuilder<RecordController>(
                        id: "price_panel",
                        builder: (state) => Chip(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          label: Text("ar ${state.total}"),
                        ),
                      )),
                  ListTile(
                      dense: true,
                      title: Row(
                        children: [
                          Text(
                            "Payé: ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(width: 8),
                          GetBuilder<RecordController>(
                            id: "debt",
                            builder: (state) => (state.debt > 0)
                                ? Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Il reste encore ${state.debt} ar à payer",
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(color: Colors.red),
                                      ),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                      trailing: GetBuilder<RecordController>(
                        id: "price_paied",
                        builder: (state) => ActionChip(
                          onPressed: () {
                            state.showBuyingDialog();
                          },
                          elevation: 2,
                          backgroundColor: (state.debt > 0)
                              ? Colors.red[300]
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          label: Text(
                            "ar ${state.paied}",
                            style: TextStyle(
                                color: (state.debt > 0)
                                    ? Colors.white
                                    : Colors.black87),
                          ),
                        ),
                      )),
                  ListTile(
                      dense: true,
                      title: Text(
                        "Rendu:",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: GetBuilder<RecordController>(
                        id: "money",
                        builder: (state) => Chip(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          label: Text("ar ${state.money}"),
                        ),
                      )),
                ],
              ),
            ),
          ),
          GetBuilder<RecordController>(
              id: "animated_container",
              builder: (state) => AnimatedContainer(
                    decoration: BoxDecoration(
                        color: state.animateContainer
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 700),
                    width: 4,
                  ))
        ],
      ),
    );
  }
}
