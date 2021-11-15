import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/article_for_listing.dart';
import '../model/purshase.dart';
import '../repository/repository.dart';
import '../view/record_page/widget/add_article_bottom_sheet.dart';
import '../view/record_page/widget/add_article_dialog.dart';
import '../view/record_page/widget/record_page_buyingDialog.dart';
import 'page_controller.dart';

class RecordController extends GetxController {
  bool _animateContainer = false;
  bool get animateContainer => _animateContainer;

  int _total = 0;
  int get total => _total;
  set total(int value) => _total = value;

  int _paied = 0;
  int get paied => _paied;
  set paied(int value) => _paied = value;

  int _money = 0;
  int get money => _money;
  set money(int value) => _money = value;

  int _debt = 0;
  int get debt => _debt;

  bool _buyingDialogValidated = false;
  bool get buyingDialogValidated => _buyingDialogValidated;

  final List<ArticleForListing> articles = [];

  static RecordController get to => Get.find();

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  final TextEditingController _pricePaiedController = TextEditingController();
  TextEditingController get pricePaiedController => _pricePaiedController;

  String _currentArticle = "Produit";
  String get currentArticle => _currentArticle;

  bool _articleNameIsvalidated = false;
  bool get articleNameIsValidated => _articleNameIsvalidated;

  bool _bottomSheetArticleInfoIsValidated = false;
  bool get bottomSheetArticleInfoIsValidated =>
      _bottomSheetArticleInfoIsValidated;

  RecordController() {
    totalRecordPrice();
  }

  Repository _repository = Repository.to;

  void addArticleToList() {
    ArticleForListing _article = ArticleForListing(
        count: 1,
        name: _currentArticle,
        price: int.parse(priceController.text),
        createdAt: DateTime.now());
    // _repository.addArticle(_article);
    if (articles.indexWhere((article) =>
            article.name.toLowerCase() == _article.name.toLowerCase()) ==
        -1) {
      print("Pas d'erreur");

      articles.add(_article);
    } else {
      print("erreur");
      showSnackBarMessage(() {},
          color: Colors.red,
          message: "Le produit existe déjà",
          title: "Erreur");
    }
    update(["record_listView"]);
  }

  void showSnackBarMessage(Function task,
      {String message, String title, Color color, bool loading = false}) {
    Get.snackbar(title, message,
        duration: Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 700),
        backgroundColor: color,
        colorText: color == Colors.white ? Colors.black87 : Colors.white,
        dismissDirection: SnackDismissDirection.VERTICAL,
        isDismissible: false,
        mainButton: TextButton(
          onPressed: () {},
          child: Text(
            "annuler".toUpperCase(),
            style: TextStyle(
                color: color == Colors.white ? Colors.black87 : Colors.white70),
          ),
        ),
        margin: EdgeInsets.only(bottom: 40),
        overlayBlur: 0,
        maxWidth: 300,
        showProgressIndicator: loading,
        progressIndicatorBackgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5, snackbarStatus: (status) {
      // if(status == SnackbarStatus.OPENING){
      task();
      // }
    });
  }

  void setanimatedContainer() async {
    for (int i = 0; i < 11; i++) {
      await Future.delayed(Duration(milliseconds: 700), () {
        _animateContainer = !_animateContainer;
        update(["animated_container"]);
      });
    }
  }

  void incrementArticleCount(int index) {
    articles[index].count++;
    articles[index].totalPriceOperation();
    totalRecordPrice();
    caluculateMoney();
    update(["record_listView", "price_panel"]);
  }

  void decrementArticleCount(int index) {
    articles[index].count--;
    articles[index].totalPriceOperation();
    totalRecordPrice();
    caluculateMoney();
    update(["record_listView", "price_panel"]);
  }

  void totalRecordPrice() {
    _total = 0;
    articles.forEach((element) {
      _total += element.totalPrice;
    });
    update(["price_panel"]);
  }

  /*
   *  ENREGISTRER UN PAYEMENT 
   */
  void showBuyingDialog() {
    Get.dialog(BuyingDialog()).then((value) {
      if (value == true) {
        _debt = 0;
        _money = 0;
        int _p = int.parse(pricePaiedController.text);
        if (_p >= total) {
          _paied = _p;
          _money = (_total - _paied).abs();
          setanimatedContainer();
          update(["price_paied", "money", "debt"]);
        } else {
          _money = 0;
          _paied = _p;
          _debt = (_total - _paied).abs();
          update(["price_paied", "debt", "money"]);
        }
      }
    });
  }

  void caluculateMoney() {
    _debt = 0;
    if (_paied != 0) {
      if (_total <= _paied) {
        _money = (_total - _paied).abs();
        update(["money", "price_paied", "debt"]);
      } else {
        _debt = (_total - _paied).abs();
        update(["price_paied", "debt"]);
      }
    }
  }

  void validateBuyingDialog() {
    if (pricePaiedController.text != "") {
      if (pricePaiedController.text.length > 1) {
        int _p = int.parse(pricePaiedController.text);
        if (_p > 0) {
          _buyingDialogValidated = true;
          update(["buying_dialog_button"]);
        } else {
          _buyingDialogValidated = false;
          update(["buying_dialog_button"]);
        }
      }
    } else {
      _buyingDialogValidated = false;
      update(["buying_dialog_button"]);
    }
  }

  void addArticle() {
    Get.bottomSheet(AddArticleBottomSheet()).then((value) {
      if (value == true) {
        addArticleToList();
        totalRecordPrice();
        caluculateMoney();
        resetBottomSheet();
      }
    });
  }

  void showArticleDialog() {
    Get.dialog(AddArticleDialog(), barrierDismissible: false).then((value) {
      if (value == true) {
        _currentArticle = nameController.text;
        update(["current_article"]);
        validateBottomSheetArticleInfo();
        resetDialog();
      } else {
        validateBottomSheetArticleInfo();
        resetDialog();
      }
    });
  }

  void setCurrentArticle(ArticleForListing article) {
    _currentArticle = article.name;
    _priceController.text = article.price.toString();
    update(["current_article"]);
    print("""
      name = ${article.name},
      price = ${article.price}
    """);
    Get.back(canPop: true);
  }

  void validateArticleName() {
    List<ArticleForListing> _articles = _repository.getArticlesList();

    if (nameController.text != "") {
      if (articles.indexWhere((article) =>
                  article.name.toLowerCase() ==
                  nameController.text.toLowerCase()) ==
              -1 &&
          _articles.indexWhere((article) =>
                  article.name.toLowerCase() ==
                  nameController.text.toLowerCase()) ==
              -1) {
        _articleNameIsvalidated = true;
        update(["add_name_button"]);
      } else {
        showSnackBarMessage(() {},
            color: Colors.red,
            message: "Le produit existe déjà dans la liste",
            title: "Erreur");
        _articleNameIsvalidated = false;
        update(["add_name_button"]);
      }
    }
  }

  void validateBottomSheetArticleInfo() {
    if (currentArticle != "Produit" && priceController.text != "") {
      _bottomSheetArticleInfoIsValidated = true;
      update(["bottom_sheet_add_button"]);
    }
  }

  void removeArticleToList(int index) {
    articles.removeAt(index);
    totalRecordPrice();
    caluculateMoney();
    update(["record_listView"]);
  }

  void resetDialog() {
    _articleNameIsvalidated = false;
    nameController.clear();
  }

  void resetBottomSheet() {
    priceController.clear();
    _currentArticle = "Produit";
  }

  void savePurshase() async {
    String ids = "";
    if (!(RecordController.to.paied >= RecordController.to.total)) {
      showSnackBarMessage(
        () {},
        color: Colors.red,
        title: "erreur",
        message:
            "Il vous manque ${RecordController.to.total - RecordController.to.paied} Ar",
      );
    } else if (articles.isEmpty) {
      showSnackBarMessage(
        () {},
        color: Colors.red,
        message: "Votre liste de produit est vide",
        title: "Erreur",
      );
    } else {
      showSnackBarMessage(() {},
          title: "Enregistrement", message: "Patientez", color: Colors.white);
      if (articles.isNotEmpty) {
        for (int i = 0; i < articles.length; i++) {
          print("Article id = ${articles[i].id}");
          if (articles[i].id.isNullOrBlank) {
            await this
                ._repository
                .addArticle(ArticleForListing(
                    count: articles[i].count,
                    name: articles[i].name,
                    price: articles[i].price,
                    createdAt: DateTime.now()))
                .then((id) {
              ids += id.toString() + ",";
              print("recu id = $ids");
            });
          }
        }
        articles.clear();
        RecordController.to.reset();
        update();
        CustomPageController.to.switchPage(0);
      }
      if (ids != "") {
        ids = ids.substring(0, ids.lastIndexOf(","));
        print(ids);
        _repository.addPurshase(Purshase(
            createdAt: DateTime.now(), paied: _paied, idArticles: ids));
      }
    }
  }

  void reset() {
    total = 0;
    paied = 0;
    money = 0;
    update();
  }
}
