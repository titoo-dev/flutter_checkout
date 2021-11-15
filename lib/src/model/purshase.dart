class Purshase{
  final int id;
  String idArticles;
  final int paied;
  final DateTime createdAt;

  Purshase({this.id, this.idArticles,this.paied, this.createdAt});

  factory Purshase.fromJsonMap(Map<String, dynamic> map){
    return Purshase(
      id: map['id'],
      idArticles: map['idArticles'],
      paied: map['paied'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
    );
  }
}