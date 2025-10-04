import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supermarket/core/widgets/app_bottom_sheet.dart';
import 'package:supermarket/models/product_model.dart';

class ProductBottomSheet extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onViewDetails;
  const ProductBottomSheet({
    super.key,
    required this.product,
    this.onDelete,
    this.onEdit,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: product.name,
      actions: [
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text('Detalhes'),
          onTap: () {
            Get.back();
            onViewDetails?.call();
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Editar'),
          onTap: () {
            Get.back();
            onEdit?.call();
          },
        ),
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
