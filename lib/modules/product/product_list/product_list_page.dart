import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/widgets/app_form_field.dart';
import 'package:supermarket/models/buy_model.dart';
import 'package:supermarket/models/product_model.dart';
import 'package:supermarket/core/widgets/item_value.dart';
import 'package:supermarket/modules/product/product_list/widget/product_bottom_sheet.dart';
import 'package:supermarket/modules/product/product_list/widget/product_item.dart';
import 'package:supermarket/routes/get_pages.dart';

import 'product_list_controller.dart';

class ProductListPage extends GetView<ProductListController> {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Produtos'),
          actions: [
            IconButton(
              onPressed: () async {
                final res = await Get.toNamed(AppPages.BACKUP);
                if (res != null && res == true) {
                  controller.findAllProducts();
                }
              },
              icon: const Icon(Icons.file_download),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var product =
                await Get.toNamed(
                      AppPages.PRODUCT_FORM,
                      arguments: controller.q.value,
                    )
                    as ProductModel?;
            if (product is ProductModel) {
              final buy = await Get.toNamed(
                AppPages.BUY_FORM,
                arguments: product,
              );
              if (buy is BuyModel) {
                product = product.addBuy(buy);
              }
              controller.addProduct(product);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.findAllProducts();
          },
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: 4),
                  AppFormField(
                    label: 'Pesquisar produto',
                    focusNode: controller.focusSearch,
                    controller: controller.controllerSearch,
                    suffixIcon: controller.focusSearch.hasFocus
                        ? IconButton(
                            onPressed: controller.clearSearch,
                            icon: Icon(Icons.close),
                          )
                        : Icon(Icons.search),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ItemValue(label: 'Nome', flex: 4),
                      ItemValue(
                        label: 'Último (R\$)',
                        textAlign: TextAlign.end,
                      ),
                      ItemValue(label: 'Média (R\$)', textAlign: TextAlign.end),
                      ItemValue(label: '', textAlign: TextAlign.end, flex: 1),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 70),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        var product = controller.products[index];
                        return InkWell(
                          onTap: () async {
                            final buy = await Get.toNamed(
                              AppPages.BUY_FORM,
                              arguments: product,
                            );
                            if (buy is BuyModel) {
                              product = product.addBuy(buy);
                              controller.editProduct(product);
                            }
                          },
                          onLongPress: () {
                            Get.bottomSheet(
                              ProductBottomSheet(
                                product: product,
                                onDelete: () =>
                                    controller.deleteProduct(product),
                                onEdit: () async {
                                  final newProduct = await Get.toNamed(
                                    AppPages.PRODUCT_FORM,
                                    arguments: product,
                                  );
                                  if (newProduct != null) {
                                    controller.editProduct(newProduct);
                                  }
                                },
                                onViewDetails: () {
                                  Get.toNamed(
                                    AppPages.PRODUCT_BUY_LIST,
                                    arguments: product,
                                  );
                                },
                              ),
                              isScrollControlled: true,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ProductItem(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
