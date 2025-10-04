class BuyModel {
  final String id;
  final double price;
  final String description;
  final DateTime date;
  BuyModel({
    required this.id,
    required this.price,
    this.description = '',
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'date': date.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory BuyModel.fromMap(map) {
    return BuyModel(
      id: map['id'] as String,
      price: (map['price'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      description: map['description'] as String? ?? '',
    );
  }
}
