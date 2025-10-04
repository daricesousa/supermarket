// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/widgets/app_snackbar.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class BuyFormController extends GetxController {
  final ProductRepository repository;
  BuyFormController({required this.repository});

  final controllerDescription = TextEditingController();
  final controllerPrice = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final ProductModel product;

  @override
  void onClose() {
    controllerDescription.dispose();
    controllerPrice.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    loadItens();
    super.onInit();
  }

  void loadItens() {
    final args = Get.arguments;
    product = args;
  }

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final description = controllerDescription.text;
        final price = double.tryParse(
            controllerPrice.text.replaceAll('R\$', '').replaceAll(',', '.'));
        if (price == null) throw 'Preço inválido';
        final buy = repository.createBuy(
          product: product,
          price: price,
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
