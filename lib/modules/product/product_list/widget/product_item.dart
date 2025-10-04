import 'package:flutter/material.dart';
import 'package:supermarket/core/extensions/double_ext.dart';
import 'package:supermarket/core/widgets/item_value.dart';
import 'package:supermarket/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemValue(label: product.name, flex: 2),
        ItemValue(
          label: product.lastPrice.displaySimplePrice(),
          textAlign: TextAlign.end,
        ),
        ItemValue(
          label: product.priceAverage.displaySimplePrice(),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
