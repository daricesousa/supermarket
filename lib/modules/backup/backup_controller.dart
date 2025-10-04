// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:supermarket/core/widgets/app_snackbar.dart';
import 'package:supermarket/repositories/backup_repository.dart';

class BackupController extends GetxController {
  final BackupRepository repository;
  BackupController({required this.repository});

  void exportProducts() async {
    try {
      await repository.export();
    } catch (e) {
      AppSnackbar.error(
        message: 'Falha ao exportar produtos',
      );
    }
  }

  Future<void> importProducts() async {
    try {
      final count = await repository.import();
      Get.back(result: true);
      AppSnackbar.success(
        message: '$count produtos importados com sucesso',
      );
    } catch (e) {
      AppSnackbar.error(
        message: 'Falha ao importar produtos',
      );
    }
  }
}
