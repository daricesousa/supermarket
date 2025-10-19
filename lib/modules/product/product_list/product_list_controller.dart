import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/repositories/product_repository.dart';

class ProductListController extends GetxController {
  final ProductRepository repository;

  ProductListController({required this.repository});

  final _products = <ProductModel>[].obs;
  final controllerSearch = TextEditingController();
  final focusSearch = FocusNode(canRequestFocus: false);

  final q = ''.obs;

  List<ProductModel> get products {
    final query = _removeAccents(q.value);
    return _products
        .where((p) {
          final name = _removeAccents(p.name);
          return name.contains(query);
        })
        .toList(growable: false)
        .reversed
        .toList(growable: false);
  }

  @override
  void onInit() {
    controllerSearch.addListener(() {
      q.value = controllerSearch.text.toUpperCase();
    });

    findAllProducts();
    super.onInit();
  }

  @override
  void onClose() {
    controllerSearch.dispose();
    focusSearch.dispose();
    super.onClose();
  }

  void findAllProducts() {
    _products.value = repository.findAll();
  }

  void addProduct(ProductModel product) {
    _products.add(product);
  }

  void editProduct(ProductModel product) {
    //update repository in form
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  void deleteProduct(ProductModel product) {
    _products.removeWhere((p) => p.id == product.id);
    repository.delete(id: product.id);
  }

  String _removeAccents(String text) {
    final normalized = text
        .toLowerCase()
        .replaceAllMapped(RegExp(r'[áàâãä]'), (_) => 'a')
        .replaceAllMapped(RegExp(r'[éèêë]'), (_) => 'e')
        .replaceAllMapped(RegExp(r'[íìîï]'), (_) => 'i')
        .replaceAllMapped(RegExp(r'[óòôõö]'), (_) => 'o')
        .replaceAllMapped(RegExp(r'[úùûü]'), (_) => 'u')
        .replaceAllMapped(RegExp(r'[ç]'), (_) => 'c');
    return normalized;
  }

  void clearSearch() {
    controllerSearch.clear();
    focusSearch.unfocus();
  }
}
