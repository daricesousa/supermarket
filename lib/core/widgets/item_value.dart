import 'package:flutter/material.dart';

class ItemValue extends StatelessWidget {
  final String label;
  final int flex;
  final TextAlign? textAlign;
  const ItemValue({
    super.key,
    required this.label,
    this.textAlign,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        textAlign: textAlign,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
