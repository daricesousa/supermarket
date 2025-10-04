import 'package:get/get.dart';
import 'package:supermarket/repositories/product_repository.dart';

import './product_form_controller.dart';

class ProductFormBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(storage: Get.find()));
    Get.put(ProductFormController(repository: Get.find()));
  }
}
