import 'package:application_caisse/src/controller/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3)
                ),
                child: TextField(
                  onChanged: (t){
                    RecordController.to.validateBuyingDialog();
                  },
                  controller: RecordController.to.pricePaiedController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(
                    hintText: "Payé en Ar"
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            GetBuilder<RecordController>(
              id: "buying_dialog_button",
              builder: (state)
                => FlatButton(
                  disabledColor: Colors.grey[400],
                  height: 50,
                  minWidth: 50,
                  onPressed: state.buyingDialogValidated 
                    ? (){
                      Get.back(canPop: true, result: true);
                    } 
                    : null, 
                  color: Theme.of(context).primaryColor,
                  child: Icon(Icons.arrow_forward, color: Colors.white,)
                )
            )
          ],
        )
      ],
    );
  }
}