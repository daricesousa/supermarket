extension StringExt on String {
  double toPrice() {
    return double.tryParse(replaceAll('R\$', '').replaceAll(',', '.')) ?? 0.0;
  }
}
