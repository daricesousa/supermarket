import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'backup_controller.dart';

class BackupPage extends GetView<BackupController> {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup')),
      body: Column(
        children: [
          InkWell(
            onTap: controller.exportProducts,
            child: Card(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ListTile(
                  title: const Text('Exportar'),
                  subtitle: const Text('Exporta os produtos para um arquivo'),
                  trailing: const Icon(Icons.file_download),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: controller.importProducts,
            child: Card(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ListTile(
                  title: const Text('Importar'),
                  subtitle: const Text('Importa os produtos de um arquivo'),
                  trailing: const Icon(Icons.file_upload),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
