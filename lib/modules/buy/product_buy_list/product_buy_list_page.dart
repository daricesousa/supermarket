import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/models/buy_model.dart';
import 'package:supermarket/modules/buy/product_buy_list/widget/buy_bottom_sheet.dart';
import 'package:supermarket/modules/buy/product_buy_list/widget/buy_item.dart';
import 'package:supermarket/core/widgets/item_value.dart';
import 'package:supermarket/routes/get_pages.dart';
import 'product_buy_list_controller.dart';

class ProductBuyListPage extends GetView<ProductBuyListController> {
  const ProductBuyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text(controller.product.name)),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final res = await Get.toNamed(
              AppPages.BUY_FORM,
              arguments: controller.product,
            );
            if (res is BuyModel) {
              controller.addBuy(res);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  ItemValue(label: 'Data'),
                  ItemValue(label: 'Descrição', textAlign: TextAlign.start),
                  ItemValue(label: 'Preço', textAlign: TextAlign.end),
                ],
              ),
              SizedBox(height: 8),
              Divider(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: controller.buys.length,
                  itemBuilder: (context, index) {
                    final buy = controller.buys[index];
                    return InkWell(
                      onTap: () async {
                        Get.bottomSheet(
                          BuyBottomSheet(
                            buy: buy,
                            onDelete: () => controller.deleteBuy(buy),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: BuyItem(buy: buy),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
