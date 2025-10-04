import 'package:get/get.dart';
import 'package:supermarket/repositories/backup_repository.dart';
import 'backup_controller.dart';

class BackupBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BackupRepository(storage: Get.find()));
    Get.put(BackupController(repository: Get.find()));
  }
}
