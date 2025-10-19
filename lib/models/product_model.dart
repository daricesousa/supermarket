import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supermarket/core/constants/constants.dart';
import 'package:supermarket/core/extensions/double_ext.dart';
import 'package:supermarket/models/buy_model.dart';

class ProductModel {
  final String id;
  final String name;
  final List<BuyModel> buys;
  final double unitSize;
  final String unitType;

  ProductModel({
    required this.id,
    required this.name,
    required this.buys,
    required this.unitSize,
    required this.unitType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'unit_size': unitSize,
      'unit_type': unitType,
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
      unitSize: map['unit_size'] ?? Constants.UNIT_SIZE_STANDARD,
      unitType: map['unit_type'] ?? Constants.UNIT_TYPE_STANDARD,
      buys: (map['buys'] as List).map((buy) => BuyModel.fromMap(buy)).toList(),
    );
  }

  ProductModel addBuy(BuyModel buy) {
    buys.insert(0, buy);
    return this;
  }

  String get fullName => '$name ($unit)';

  String get unit =>
      '${unitSize.displayIntOrDouble(decimalPlaces: 3)}$unitType';

  int get priceTrend {
    if (lastPrice < priceAverage) {
      return 1;
    }
    if (lastPrice > priceAverage) {
      return -1;
    }
    return 0;
  }

  Icon get priceArrowIcon {
    if (lastPrice < priceAverage) {
      return const Icon(Icons.arrow_downward, color: Colors.green);
    }
    if (lastPrice > priceAverage) {
      return const Icon(Icons.arrow_upward, color: Colors.red);
    }
    return const Icon(Icons.remove, color: Colors.grey);
  }
}
