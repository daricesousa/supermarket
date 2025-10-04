import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/extensions/double_ext.dart';
import 'package:supermarket/core/widgets/app_bottom_sheet.dart';
import 'package:supermarket/models/buy_model.dart';

class BuyBottomSheet extends StatelessWidget {
  final BuyModel buy;
  final VoidCallback? onDelete;

  const BuyBottomSheet({super.key, required this.buy, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: buy.price.displaySimplePrice(),
      actions: [
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Excluir'),
          onTap: () {
            Get.back();
            onDelete?.call();
          },
        ),
      ],
    );
  }
}
