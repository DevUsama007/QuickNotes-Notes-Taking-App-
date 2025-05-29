import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerUtils {
  /// Picks a single file with optional file type filtering
  static Future<PlatformFile?> pickFile({
    List<String>? allowedExtensions,
    String? dialogTitle,
    FileType type = FileType.any,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle,
        withData: true, // Loads file bytes in memory
      );

      return result?.files.first;
    } catch (e) {
      debugPrint('File picker error: $e');
      return null;
    }
  }

  /// Picks a directory (only works on some platforms)
}
