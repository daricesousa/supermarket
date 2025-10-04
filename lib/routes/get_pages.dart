// ignore_for_file: constant_identifier_names

import 'package:get/route_manager.dart';
import 'package:supermarket/modules/backup/backup_bindings.dart';
import 'package:supermarket/modules/backup/backup_page.dart';
import 'package:supermarket/modules/buy/buy_form/buy_form_bindings.dart';
import 'package:supermarket/modules/buy/buy_form/buy_form_page.dart';
import 'package:supermarket/modules/buy/product_buy_list/product_buy_list_bindings.dart';
import 'package:supermarket/modules/buy/product_buy_list/product_buy_list_page.dart';
import 'package:supermarket/modules/product/product_form/product_form_bindings.dart';
import 'package:supermarket/modules/product/product_form/product_form_page.dart';
import 'package:supermarket/modules/product/product_list/product_list_bindings.dart';
import 'package:supermarket/modules/product/product_list/product_list_page.dart';

sealed class AppPages {
  static const PRODUCT_LIST = '/product/list';
  static const PRODUCT_FORM = '/product/form';

  static const PRODUCT_BUY_LIST = '/product/buy/list';
  static const BUY_FORM = '/product/buy/form';

  static const BACKUP = '/backup';
}

final appGetPages = [
  GetPage(
      name: AppPages.PRODUCT_FORM,
      page: () => ProductFormPage(),
      binding: ProductFormBindings()),
  GetPage(
    name: AppPages.PRODUCT_LIST,
    page: () => ProductListPage(),
    binding: ProductListBindings(),
  ),
  GetPage(
      name: AppPages.PRODUCT_BUY_LIST,
      page: () => ProductBuyListPage(),
      binding: ProductBuyListBindings()),
  GetPage(
    name: AppPages.BUY_FORM,
    page: () => BuyFormPage(),
    binding: BuyFormBindings(),
  ),
  GetPage(
    name: AppPages.BUY_FORM,
    page: () => BuyFormPage(),
    binding: BuyFormBindings(),
  ),
  GetPage(
    name: AppPages.BACKUP,
    page: () => BackupPage(),
    binding: BackupBindings(),
  ),
];
