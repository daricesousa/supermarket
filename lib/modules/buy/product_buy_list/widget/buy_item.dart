import 'package:flutter/material.dart';
import 'package:supermarket/core/extensions/date_ext.dart';
import 'package:supermarket/core/extensions/double_ext.dart';
import 'package:supermarket/core/widgets/item_value.dart';
import 'package:supermarket/models/buy_model.dart';

class BuyItem extends StatelessWidget {
  final BuyModel buy;

  const BuyItem({
    super.key,
    required this.buy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemValue(label: buy.date.displayDate()),
        ItemValue(label: buy.description),
        ItemValue(
          label: buy.price.displaySimplePrice(),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
