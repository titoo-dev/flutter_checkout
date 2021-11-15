import 'dart:io';
import 'package:application_caisse/src/model/article_for_listing.dart';
import 'package:application_caisse/src/model/purshase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';

class Db {
  static const String _dbfileName = "caisse.db";
  static const String _article = "article";
  static const String _purshase = "purshase";

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Database _db;

  List<ArticleForListing> _articles = [];
  List<ArticleForListing> get articles => this._articles;

  Future<void> initDb() async {
    final dbFolder = await getDatabasesPath();

    if (!await Directory(dbFolder).exists()) {
      // await Directory(dbFolder).delete(recursive: true);
      await Directory(dbFolder).create(recursive: true);
    }

    final dbPath = join(dbFolder, _dbfileName);

    this._db = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $_article(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            price INT, 
            count INTEGER,
            createdAt INT
          );
          
        ''');
      await db.execute('''
          CREATE TABLE $_purshase(
            id INTEGER PRIMARY KEY,
            idArticles TEXT NOT NULL,
            paied INT,
            createdAt INT
          )
        ''');
    });
  }

  Future<List<ArticleForListing>> getArticles() async {
    List<Map> jsons = await this
        ._db
        .rawQuery('SELECT * FROM $_article ORDER BY(CreatedAt) DESC');
    print('${jsons.length} row retirés de la base de donnée');
    this._articles =
        jsons.map((json) => ArticleForListing.fromJson(json)).toList();
    return this._articles;
  }

  Future<int> addArticle(ArticleForListing article) async {
    int _id;
    await this._db.transaction((Transaction txn) async {
      _id = await txn.rawInsert('''
          INSERT INTO $_article
            (name, count, price, createdAt)
          VALUES 
            (
              "${article.name}",
              "${article.count}",
              "${article.price}",
              "${article.createdAt.millisecondsSinceEpoch}"
            )
        ''');
      print("Article insere avec l'identifiant id=$_id");
    });
    return _id;
  }

  Future<void> addPurshase(Purshase purshase) async {
    await this._db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('''
          INSERT INTO $_purshase
            (idArticles, paied, createdAt)
          VALUES 
            (
              "${purshase.idArticles}",
              "${purshase.paied}",
              "${purshase.createdAt.millisecondsSinceEpoch}"
            )
        ''');
      print("Achat insere avec l'identifiant id=$id");
    });
  }

  Future<void> updateArticle(ArticleForListing newArticle) async {
    int count = await this._db.rawUpdate('''
      UPDATE $_article
        SET name = ${newArticle.name}
        WHERE id = ${newArticle.id}
    ''');
    print("$count mise à jour effectué");
  }

  Future<void> deleteArticle(int id) async {
    final count = await this._db.rawDelete('''
      DELETE FROM $_article
      WHERE id = $id
    ''');
    print("$count article supprime de la base de donnée");
  }

  Future<bool> asyncInit() async {
    await _memoizer.runOnce(() async {
      await initDb();
      await getArticles();
    });
    print("Base de donnée initialisé");
    return true;
  }
}
