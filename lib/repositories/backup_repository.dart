import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supermarket/core/utils/storage_keys.dart';

class BackupRepository {
  final GetStorage storage;

  BackupRepository({required this.storage});

  Future<void> export() async {
    final str = _getData();
    final file = await _saveTxt(str!);
    await _shareFile(file!);
  }

  String? _getData() {
    final res = storage.read(StorageKeys.products) as List?;
    if (res == null || res.isEmpty) return null;
    return jsonEncode(res);
  }

  Future<File?> _saveTxt(String str) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/products.txt');
    return await file.writeAsString(str);
  }

  Future<void> _shareFile(File file) async {
    await SharePlus.instance.share(ShareParams(
      text: 'Produtos exportados',
      files: [XFile(file.path)],
    ));
  }

  Future<int> import() async {
    final file = await _getFile();

    final content = await file!.readAsString();
    final data = jsonDecode(content) as List;

    final products = data.map((e) => e as Map<String, dynamic>).toList();
    storage.write(StorageKeys.products, products);

    return products.length;
  }

  Future<File?> _getFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (res == null || res.files.single.path == null) return null;
    final path = res.files.single.path!;
    return File(path);
  }
}
