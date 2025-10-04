import 'package:supermarket/models/buy_model.dart';

class ProductModel {
  final String id;
  final String name;
  final List<BuyModel> buys;

  ProductModel({
    required this.id,
    required this.name,
    required this.buys,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'buys': buys.map((buy) => buy.toMap()).toList(),
    };
  }

  double get priceAverage {
    return buys.isEmpty
        ? 0
        : (buys.map((buy) => buy.price).reduce((a, b) => a + b) / buys.length);
  }

  double get lastPrice {
    return buys.isEmpty ? 0 : buys.first.price; //lista salva inversamente
  }

  factory ProductModel.fromMap(map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      buys: (map['buys'] as List).map((buy) => BuyModel.fromMap(buy)).toList(),
    );
  }

  ProductModel addBuy(BuyModel buy) {
    buys.insert(0, buy);
    return this;
  }
}
