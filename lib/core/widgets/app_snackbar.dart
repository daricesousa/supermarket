import 'package:flutter/material.dart';
import 'package:get/get.dart';

sealed class AppSnackbar {
  static void success({String? message}) {
    Get.snackbar('', '',
        titleText: Text(
          'Sucesso',
          style: const TextStyle(color: Colors.white),
        ),
        messageText: Text(
          message ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void error({String? message}) {
    Get.snackbar('', '',
        titleText: Text(
          'Ops...',
          style: const TextStyle(color: Colors.white),
        ),
        messageText: Text(
          message ?? 'Algo deu errado',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
