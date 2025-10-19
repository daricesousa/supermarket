import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/constants/constants.dart';
import 'package:supermarket/core/widgets/app_snackbar.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class ProductFormController extends GetxController {
  final ProductRepository repository;
  ProductFormController({required this.repository});

  final controllerName = TextEditingController();
  final controllerUnitSize = TextEditingController();
  final controllerUnitType = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ProductModel? product;

  @override
  void onClose() {
    controllerName.dispose();
    controllerUnitSize.dispose();
    controllerUnitType.dispose();
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
      controllerUnitSize.text = product!.unitSize.toString();
      controllerUnitType.text = product!.unitType.toString();
    } else {
      controllerUnitSize.text = Constants.UNIT_SIZE_STANDARD.toString();
      controllerUnitType.text = Constants.UNIT_TYPE_STANDARD.toString();
    }

    if (args is String) {
      controllerName.text = args;
    }
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final name = controllerName.text;
        final unitSize = double.parse(controllerUnitSize.text);
        final unitType = controllerUnitType.text;
        if (product != null) {
          final res = repository.update(
            product: ProductModel(
              id: product!.id,
              name: name,
              buys: product!.buys,
              unitSize: unitSize,
              unitType: unitType,
            ),
          );
          Get.back(result: res);
        } else {
          final res = repository.create(
            name: name,
            unitSize: unitSize,
            unitType: unitType,
          );
          Get.back(result: res);
        }
        // AppSnackbar.success(message: 'Produto salvo com sucesso');
      } catch (e) {
        AppSnackbar.error(message: e.toString());
      }
    }
  }
}
