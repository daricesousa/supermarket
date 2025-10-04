extension DoubleExt on double {
  String displayPrice() {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String displaySimplePrice() {
    return toStringAsFixed(2).replaceAll('.', ',');
  }

  String displayIntOrDouble() {
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toStringAsFixed(2).replaceAll('.', ',');
    }
  }
}

extension StringExt on String {
  double toPrice() {
    return double.tryParse(
          replaceAll('R\$', '').replaceAll(',', '.'),
        ) ??
        0.0;
  }
}
