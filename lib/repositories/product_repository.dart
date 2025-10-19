import 'package:get_storage/get_storage.dart';
import 'package:supermarket/core/constants/constants.dart';
import 'package:supermarket/core/utils/storage_keys.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/models/buy_model.dart';

class ProductRepository {
  final GetStorage storage;
  ProductRepository({required this.storage});

  List<ProductModel> findAll() {
    // storage.write('products', <Map<String, dynamic>>[]);
    final res = storage.read(StorageKeys.products);
    if (res == null) return [];
    return List<ProductModel>.from((res as List).map(ProductModel.fromMap));
  }

  ProductModel create({
    required String name,
    required double unitSize,
    required String unitType,
  }) {
    final products = findAll();

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final product = ProductModel(
      id: id,
      name: name,
      buys: [],
      unitSize: unitSize,
      unitType: unitType,
    );
    products.add(product);
    storage.write(
      StorageKeys.products,
      products.map((p) => p.toMap()).toList(),
    );
    return product;
  }

  void delete({required String id}) {
    final products = findAll();
    final index = products.indexWhere((p) => p.id == id);
    if (index == -1) throw 'Produto não encontrado';
    products.removeAt(index);
    storage.write(
      StorageKeys.products,
      products.map((p) => p.toMap()).toList(),
    );
  }

  ProductModel update({required ProductModel product}) {
    final products = findAll();
    final index = products.indexWhere((p) => p.id == product.id);

    if (index == -1) throw 'Produto não encontrado';
    products.removeAt(index);
    products.add(product);

    storage.write(
      StorageKeys.products,
      products.map((p) => p.toMap()).toList(),
    );
    return product;
  }

  BuyModel createBuy({
    required ProductModel product,
    required double price,
    String description = '',
  }) {
    final buy = BuyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      price: price,
      description: description,
      date: DateTime.now(),
    );
    final lastBuys = product.buys;
    if (lastBuys.length == Constants.LIMITE_BUYS) {
      lastBuys.removeLast();
    }
    final productEdit = ProductModel(
      id: product.id,
      name: product.name,
      unitSize: product.unitSize,
      unitType: product.unitType,
      buys: [buy, ...lastBuys],
    );
    update(product: productEdit);
    return buy;
  }
}
