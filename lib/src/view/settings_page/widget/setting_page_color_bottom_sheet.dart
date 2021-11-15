import 'package:application_caisse/src/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2), color: Colors.black54, blurRadius: 20),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: GridView.count(
        crossAxisCount: 4,
        scrollDirection: Axis.vertical,
        children: List.generate(
            AppController.to.colors.length,
            (index) => InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: AppController.to.colors[index],
                    ),
                  ),
                  onTap: () {
                    Get.back(canPop: true);
                    Future.delayed(Duration(milliseconds: 500), () {
                      AppController.to
                          .setAppTheme(AppController.to.colors[index]);
                    });
                  },
                )),
      ),
      // child: ListView.builder(
      //     itemCount: AppController.to.colors.length + 1,
      //     itemBuilder: (context, index) {
      //       if (index == 0) {
      //         return ListTile(
      //           onTap: () {
      //             Get.back();
      //           },
      //           tileColor: Colors.grey[100],
      //           title: Text("Annuler"),
      //         );
      //       }
      //       return ListTile(
      // onTap: () {
      //   Get.back(canPop: true);
      //   Future.delayed(Duration(milliseconds: 700), () {
      //     AppController.to
      //         .setAppTheme(AppController.to.colors[index - 1]);
      //   });
      // },
      //         leading: CircleAvatar(
      //           backgroundColor: AppController.to.colors[index - 1],
      //         ),
      //         title: Text(AppController.to.colors[index - 1].toString()),
      //       );
      //     }),
    );
  }
}
