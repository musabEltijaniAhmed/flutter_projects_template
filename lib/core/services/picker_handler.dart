import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_project_template/core/constants/app_string.dart';
import 'package:flutter_project_template/core/domain/entity/alert_model.dart';
import 'package:flutter_project_template/core/services/permission_handler.dart';
import 'package:flutter_project_template/core/util/print_info.dart';
import 'package:flutter_project_template/core/widgets/dialogs/quickalert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

/// Example usage:
/// ```dart
/// // Pick a single image from gallery
/// final image = await PickerHandler().pickImageFromGallery(context);
///
/// // Pick a single image from camera
/// final image = await PickerHandler().pickImageFromCamera(context);
///
/// // Pick multiple images from gallery
/// final images = await PickerHandler().pickMultipleImages(context);
///
/// // Pick a single file with specific allowed extensions
/// final file = await PickerHandler().pickFile(context, allowedExtensions: ['pdf', 'docx']);
///
/// // Pick multiple files with specific allowed extensions
/// final files = await PickerHandler().pickMultipleFiles(context, allowedExtensions: ['pdf', 'docx']);
class PickerHandler {
  // Private static instance
  static PickerHandler? _instance;
  final ImagePicker _imagePicker = ImagePicker();
  final PermissionHandler _permissionHandler = PermissionHandler();

  // Private constructor
  PickerHandler._();

  // Factory constructor
  factory PickerHandler() {
    _instance ??= PickerHandler._();
    return _instance!;
  }

  /// Pick a single image from gallery
  Future<File?> pickImageFromGallery(BuildContext context) async {
    try {
      final hasPermission = await _permissionHandler.checkPermission(
        Permission.photos,
        context,
        AppMessage.accessImage,
      );

      if (!hasPermission) return null;

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        // Check file size (1MB = 1048576 bytes)
        if (await file.length() > 1048576) {
          if (context.mounted) {
            Alert.show(
              context: context,
              type: AlertType.error,
              title: AppMessage.imageReachedLimit,
            );
          }
          return null;
        }
        return file;
      }
      return null;
    } catch (e) {
      printInfo(e.toString());
      if (context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.error,
          title: AppMessage.unknownError,
        );
      }
      return null;
    }
  }

  /// Pick a single image from camera
  Future<File?> pickImageFromCamera(BuildContext context) async {
    try {
      final hasPermission = await _permissionHandler.checkPermission(
        Permission.camera,
        context,
        AppMessage.cameraPermissionRequired,
      );

      if (!hasPermission) return null;

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        // Check file size (1MB = 1048576 bytes)
        if (await file.length() > 1048576) {
          if (context.mounted) {
            Alert.show(
              context: context,
              type: AlertType.error,
              title: AppMessage.imageReachedLimit,
            );
          }
          return null;
        }
        return file;
      }
      return null;
    } catch (e) {
      printInfo(e.toString());
      if (context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.error,
          title: AppMessage.unknownError,
        );
      }
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleImages(BuildContext context) async {
    try {
      final hasPermission = await _permissionHandler.checkPermission(
        Permission.photos,
        context,
        AppMessage.accessImage,
      );

      if (!hasPermission) return [];

      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 80,
      );

      final List<File> validFiles = [];
      for (final image in images) {
        final file = File(image.path);
        if (await file.length() <= 1048576) {
          validFiles.add(file);
        }
      }

      if (validFiles.length != images.length && context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.warning,
          title: AppMessage.imageReachedLimit,
        );
      }

      return validFiles;
    } catch (e) {
      printInfo(e.toString());
      if (context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.error,
          title: AppMessage.unknownError,
        );
      }
      return [];
    }
  }

  /// Pick a single file with specific allowed extensions
  Future<File?> pickFile(
    BuildContext context, {
    List<String>? allowedExtensions,
  }) async {
    try {
      final hasPermission = await _permissionHandler.checkPermission(
        Permission.storage,
        context,
        AppMessage.storagePermissionRequired,
      );

      if (!hasPermission) return null;

      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      printInfo(e.toString());
      if (context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.error,
          title: AppMessage.unknownError,
        );
      }
      return null;
    }
  }

  /// Pick multiple files with specific allowed extensions
  Future<List<File>> pickMultipleFiles(
    BuildContext context, {
    List<String>? allowedExtensions,
  }) async {
    try {
      final hasPermission = await _permissionHandler.checkPermission(
        Permission.storage,
        context,
        AppMessage.storagePermissionRequired,
      );

      if (!hasPermission) return [];

      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        return result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();
      }
      return [];
    } catch (e) {
      printInfo(e.toString());
      if (context.mounted) {
        Alert.show(
          context: context,
          type: AlertType.error,
          title: AppMessage.unknownError,
        );
      }
      return [];
    }
  }
}
