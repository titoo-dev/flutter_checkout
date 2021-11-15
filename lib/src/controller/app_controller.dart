import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../view/main_page/main_page.dart';
import '../view/settings_page/setting_page.dart';
import '../view/settings_page/widget/setting_page_color_bottom_sheet.dart';
import '../view/story_page/story_page.dart';
import 'record_controller.dart';

class AppController extends GetxController {
  var doc = pw.Document();

  final List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.grey,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.yellow
  ];

  String _currentPage = "main";
  String get currentpage => _currentPage;

  static AppController get to => Get.find();

  void goToPage(String page) {
    Get.back();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (page == "main") {
        _currentPage = page;
        Get.to(MainPage(), transition: Transition.fadeIn);
      } else if (page == "params") {
        _currentPage = page;
        Get.to(SettingPage(), transition: Transition.fadeIn);
      } else if (page == "hist") {
        Get.to(StoryPage(), transition: Transition.fadeIn);
      }
    });
  }

  void printData() {
    if (RecordController.to.articles.isNotEmpty &&
        RecordController.to.paied >= RecordController.to.total) {
      doc = pw.Document();
      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a5,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Container(
                child: pw.Text("Societe X",
                    style: pw.TextStyle(
                        fontSize: 25, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center),
              ),
              pw.SizedBox(height: 40),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Désignation",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Quantité",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("P.U.",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 20),
              pw.Flexible(
                flex: 1,
                child: pw.Container(
                    child: pw.Column(
                  children: RecordController.to.articles
                      .map((e) => pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(e.name,
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(e.count.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(e.price.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold)),
                              ]))
                      .toList(),
                )),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total: ",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(RecordController.to.total.toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Payé: ",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(RecordController.to.paied.toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Rendu: ",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(RecordController.to.money.toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ])
            ]);
          }));
      Get.to(const MyPdfViewer());
    } else if (!(RecordController.to.paied >= RecordController.to.total)) {
      showSnackBarMessage(
          title: "erreur",
          message:
              "Il vous manque ${RecordController.to.total - RecordController.to.paied} Ar");
    } else {
      showSnackBarMessage(
          title: "erreur", message: "Votre liste de produit est vide");
    }
  }

  void goBack() {
    Get.back();
    _currentPage = "main";
    update(["drawer"]);
  }

  void setAppTheme(Color color) {
    Get.changeTheme(ThemeData(primarySwatch: color));
  }

  void showColors() {
    Get.bottomSheet(ColorBottomSheet(),
        barrierColor: Colors.transparent, isDismissible: true, elevation: 3);
  }
}

class MyPdfViewer extends StatelessWidget {
  const MyPdfViewer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) {
          return AppController.to.doc.save();
        },
      ),
    );
  }
}

void showSnackBarMessage(
    {String message, String title, Color color, bool loading = false}) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 700),
    backgroundColor: Colors.red,
    colorText: Colors.white,
    dismissDirection: SnackDismissDirection.VERTICAL,
    isDismissible: false,
    mainButton: TextButton(
      onPressed: () {},
      child: Text(
        "annuler".toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    ),
    margin: const EdgeInsets.only(bottom: 40),
    overlayBlur: 0,
    maxWidth: 300,
    showProgressIndicator: false,
    progressIndicatorBackgroundColor: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 5,
  );
}
