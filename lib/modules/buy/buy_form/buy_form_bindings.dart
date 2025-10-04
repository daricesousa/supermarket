import 'package:get/get.dart';
import 'package:supermarket/repositories/product_repository.dart';

import 'buy_form_controller.dart';

class BuyFormBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(storage: Get.find()));
    Get.put(BuyFormController(repository: Get.find()));
  }
}
