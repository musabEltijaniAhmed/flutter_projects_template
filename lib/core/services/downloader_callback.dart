import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:matryal_seller/core/constants/app_string.dart';
import 'package:matryal_seller/core/widgets/app_snack_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
/// Example usage in a StatefulWidget:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   _MyWidgetState createState() => _MyWidgetState();
/// }
/// 
/// class _MyWidgetState extends State<MyWidget> {
///   // Create a new port for the downloader callback
///   final ReceivePort _port = ReceivePort('downloader_send_port');
///
///   @override
///   void initState() {
///     super.initState();
///     // Start the downloader process
///     DownloaderService.startDownloadProcess(_port);
///   }
///
///   @override 
///   void dispose() {
///     // Important:
///     // Close the port to prevent memory leaks
///     // Remove the port mapping and close the port
///     IsolateNameServer.removePortNameMapping('downloader_send_port');
///     _port.close();
///     super.dispose();
///   }
///
///   void _downloadFile() async {
///     await DownloaderService().downloadFile(
///       url: "https://example.com/file.pdf",
///       fileName: "downloaded_file.pdf"
///     );
///   }
/// }
/// ```
@pragma('vm:entry-point')
class DownloaderService {
  static final DownloaderService _instance = DownloaderService._internal();

  factory DownloaderService() {
    return _instance;
  }

  DownloaderService._internal();

  @pragma('vm:entry-point')
  static void downloaderCallback(String id, int status, int progress) {
    log("Download task ($id) is in status: $status and progress: $progress%");
    final SendPort? send = IsolateNameServer.lookupPortByName(
      'downloader_send_port',
    );
    log('=================($progress)===================');
    send?.send([id, status, progress]);
  }

  Future<void> downloadFile({String? url, String? fileName}) async {
    log('downloadFile');
    final folder = await createFolder();
    try {
      if (FlutterDownloader.initialized == false) {
        await FlutterDownloader.initialize(debug: kDebugMode, ignoreSsl: true);
      }

      final taskId = await FlutterDownloader.enqueue(
        url: url ?? "",
        saveInPublicStorage: true,
        savedDir: folder,
        fileName: fileName,
        timeout: 20000,
      ).then((value) {
        log('value $value');
      });
      log('taskId $taskId');
    } catch (e) {
      //
    }
  }

  Future<String> createFolder() async {
    var mPath = "storage/emulated/0/Download/";
    if (Platform.isIOS) {
      final iosPath = await getApplicationDocumentsDirectory();
      mPath = iosPath.path;
    }
    // print("path = $mPath");
    final dir = Directory(mPath);

    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // ignore: avoid_slow_async_io
    if ((await dir.exists())) {
      return dir.path;
    } else {
      await dir.create();
      return dir.path;
    }
  }

  static void startDownloadProcess(ReceivePort port) {
    log('startDownloadProcess');

    // First remove any existing port mapping
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    // Register new port
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );

    // Cancel any existing listeners before adding a new one
    port.listen(
      (dynamic data) {
        final String id = data[0];
        final DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
        final int progress = data[2];
        log(
          'Download task ($id) is in status ($status) and process ($progress)',
        );
        if (status == DownloadTaskStatus.complete) {
          log('Download completed: $id');
          AppSnackBar.show(
            message: AppMessage.downloadCompleted,
            isSuccessful: true,
          );
          FlutterDownloader.open(taskId: id);
        }
      },
      cancelOnError: true, // Cancel listener on error
    );
  }
}
