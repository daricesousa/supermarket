// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/extensions/string_ext.dart';
import 'package:supermarket/core/widgets/app_snackbar.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class BuyFormController extends GetxController {
  final ProductRepository repository;
  BuyFormController({required this.repository});

  final controllerDescription = TextEditingController();
  final controllerPrice = TextEditingController();
  final controllerUnitSize = TextEditingController();
  final controllerPriceConverted = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final ProductModel product;
  final diferenceAverage = Rxn<double>();

  @override
  void onClose() {
    controllerUnitSize.removeListener(updatePriceConverted);
    controllerPrice.removeListener(updatePriceConverted);
    controllerDescription.dispose();
    controllerPrice.dispose();
    controllerUnitSize.dispose();
    controllerPriceConverted.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    controllerPrice.addListener(updatePriceConverted);
    controllerUnitSize.addListener(updatePriceConverted);

    loadItens();
    super.onInit();
  }

  updatePriceConverted() {
    final total =
        product.unitSize *
        controllerPrice.text.toPrice() /
        double.parse(controllerUnitSize.text);
    controllerPriceConverted.text = total.toStringAsFixed(2);
    if (total == 0 || product.priceAverage == 0)
      diferenceAverage.value = null;
    else {
      diferenceAverage.value = product.priceAverage - total;
    }
  }

  void loadItens() {
    final args = Get.arguments;
    product = args;
    controllerUnitSize.text = product.unitSize.toString();
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final description = controllerDescription.text;
        final convertedPrice = double.tryParse(
          controllerPriceConverted.text
              .replaceAll('R\$', '')
              .replaceAll(',', '.'),
        );
        if (convertedPrice == null) throw 'Preço inválido';
        final buy = repository.createBuy(
          product: product,
          price: convertedPrice,
          description: description,
        );
        Get.back(result: buy);
        AppSnackbar.success(message: 'Compra salva com sucesso');
      } catch (e) {
        AppSnackbar.error(message: e.toString());
      }
    }
  }
}
