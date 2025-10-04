extension DateExt on DateTime {
  String displayDate() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }
}
