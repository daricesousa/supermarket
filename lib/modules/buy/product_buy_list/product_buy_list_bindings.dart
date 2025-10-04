import 'package:get/get.dart';
import 'package:supermarket/repositories/product_repository.dart';

import 'product_buy_list_controller.dart';

class ProductBuyListBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(storage: Get.find()));
    Get.put(ProductBuyListController(repository: Get.find()));
  }
}
