import 'package:get/get.dart';
import 'package:supermarket/models/buy_model.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class ProductBuyListController extends GetxController {
  final ProductRepository repository;

  ProductBuyListController({required this.repository});

  final buys = <BuyModel>[].obs;
  late final ProductModel product;

  @override
  void onInit() {
    findProduct();
    super.onInit();
  }

  void findProduct() {
    final args = Get.arguments;
    if (args is ProductModel) {
      product = args;
      findAllBuys(product);
    }
  }

  void findAllBuys(ProductModel product) {
    buys.value = product.buys;
  }

  void addBuy(BuyModel buy) {
    buys.add(buy);
    updateBuysByProduct();
  }

  void deleteBuy(BuyModel buy) {
    buys.removeWhere((b) => b.id == buy.id);
    updateBuysByProduct();
  }

  updateBuysByProduct() {
    repository.update(
      product: ProductModel(
        id: product.id,
        name: product.name,
        buys: [...buys],
        unitSize: product.unitSize,
        unitType: product.unitType,
      ),
    );
  }
}
