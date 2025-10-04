import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/widgets/app_snackbar.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class ProductFormController extends GetxController {
  final ProductRepository repository;
  ProductFormController({required this.repository});

  final controllerName = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ProductModel? product;

  @override
  void onClose() {
    controllerName.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    loadItens();

    super.onInit();
  }

  void loadItens() {
    final args = Get.arguments;
    if (args is ProductModel) {
      product = args;
      controllerName.text = product!.name;
    } else if (args is String) {
      controllerName.text = args;
    }
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final name = controllerName.text;
        if (product != null) {
          final res = repository.update(
            product: ProductModel(
              id: product!.id,
              name: name,
              buys: product!.buys,
            ),
          );
          Get.back(result: res);
        } else {
          final res = repository.create(name: name);
          Get.back(result: res);
        }
        // AppSnackbar.success(message: 'Produto salvo com sucesso');
      } catch (e) {
        AppSnackbar.error(message: e.toString());
      }
    }
  }
}
