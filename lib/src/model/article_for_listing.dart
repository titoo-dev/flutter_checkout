
class ArticleForListing {
  final int id;

  final String name;
  final price;
  int _count;
  int totalPrice;
  final DateTime createdAt;

  ArticleForListing({
    this.id,
    this.name, 
    this.price, 
    int count,
    this.createdAt
  }){
    this.count = count; 
    this.totalPriceOperation();
  }

  void totalPriceOperation(){
    totalPrice = count * price;
  }

  int get count => this._count;

  set count(int value){
    if(value <= 20 && value > 0){
      this._count = value;
    }
  }

  factory ArticleForListing.fromJson(Map<String, dynamic> json){
    return ArticleForListing(
      id: json["id"],
      count: json["count"],
      name: json["name"],
      price: json["price"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'count': count,
    'name': name,
    'price': price,
    'createdAt': createdAt.millisecondsSinceEpoch
  };
}