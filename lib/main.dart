import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supermarket/core/bindings/app_bindings.dart';
import 'package:supermarket/routes/get_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: appGetPages,
      initialRoute: AppPages.PRODUCT_LIST,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}
