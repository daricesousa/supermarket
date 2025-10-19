extension DoubleExt on double {
  String displayPrice() {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String displaySimplePrice() {
    return toStringAsFixed(2).replaceAll('.', ',');
  }

  String displayIntOrDouble({int decimalPlaces = 2}) {
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toStringAsFixed(decimalPlaces).replaceAll('.', ',');
    }
  }
}


