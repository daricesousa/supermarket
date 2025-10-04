import 'package:get/get.dart';
import 'package:supermarket/repositories/product_repository.dart';

import 'product_list_controller.dart';

class ProductListBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(storage: Get.find()));
    Get.put(ProductListController(repository: Get.find()));
  }
}
