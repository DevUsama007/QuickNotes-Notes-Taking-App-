import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class DownloadController extends GetxController {
  // Observable variables
  var downloadProgress = 0.obs;
  var isDownloading = false.obs;
  var downloadComplete = false.obs;
  var filePath = ''.obs;
  var errorMessage = ''.obs;

  // Download file method
  Future<void> downloadFile(String url, String fileName, String appName) async {
    try {
      print(fileName);
      // Reset state
      isDownloading.value = true;
      downloadComplete.value = false;
      downloadProgress.value = 0;
      errorMessage.value = '';

      // Check and request storage permission
      final status = await Permission.audio.request();
      if (!status.isGranted) {
        throw Exception('Storage permission denied');
      }

      // Get downloads directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = await getExternalStorageDirectory();
        final List<String> paths = downloadsDir!.path.split('/');
        String newPath = '';
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != 'Android') {
            newPath += '/$folder';
          } else {
            break;
          }
        }
        newPath = '$newPath/Download';
        downloadsDir = Directory(newPath);
      } else if (Platform.isIOS) {
        downloadsDir = await getDownloadsDirectory();
      }

      if (downloadsDir == null) {
        throw Exception('Could not access downloads directory');
      }

      // Create app directory
      final appDir = Directory('${downloadsDir.path}/$appName');
      if (!await appDir.exists()) {
        await appDir.create(recursive: true);
      }

      // Download using Dio
      final dio = Dio();
      final savePath = '${appDir.path}/$fileName';

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = ((received / total) * 100).toInt();
          }
        },
      );

      // Update state on success
      filePath.value = savePath;
      downloadComplete.value = true;
    } catch (e) {
      errorMessage.value = 'Download failed: $e';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isDownloading.value = false;
    }
  }

  // Open downloaded file
  Future<void> openDownloadedFile() async {
    if (filePath.value.isNotEmpty) {
      try {
        await OpenFile.open(filePath.value);
      } catch (e) {
        errorMessage.value = 'Failed to open file: $e';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
