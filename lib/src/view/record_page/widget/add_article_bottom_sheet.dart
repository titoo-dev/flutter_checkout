import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddArticleBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                GetBuilder<RecordController>(
                  id: "current_article",
                  builder: (state)
                    => ActionChip(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        padding: EdgeInsets.only(left: 8, right: 8),
                        elevation: 2,
                        label: Text(state.currentArticle), 
                        onPressed: (){
                          state.showArticleDialog();
                        }
                      ),
                ),
                Spacer(),

                Container(
                  width: 120,
                  child: TextField(
                    onChanged: (text){
                      RecordController.to.validateBottomSheetArticleInfo();
                    },
                    controller: RecordController.to.priceController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintText: "Prix",
                      hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<RecordController>(
                  id: "bottom_sheet_add_button",
                  builder: (state)
                    => FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        textColor: state.bottomSheetArticleInfoIsValidated 
                          ? Colors.white
                          : Colors.black38,
                        color: state.bottomSheetArticleInfoIsValidated 
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.3),
                        onPressed: state.bottomSheetArticleInfoIsValidated
                          ? (){
                            Get.back(canPop: true, result: true);
                          }
                          : ()=>{}, 
                        child: Text("ajouter".toUpperCase())
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}