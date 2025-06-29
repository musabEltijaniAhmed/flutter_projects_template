import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/constants/app_string.dart';
import 'package:flutter_project_template/core/domain/entity/alert_model.dart';
import 'package:flutter_project_template/core/enums/permission_enums.dart';
import 'package:flutter_project_template/core/util/print_info.dart';
import 'package:flutter_project_template/core/widgets/dialogs/quickalert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

/// Example usage:
/// ```dart
/// // Check camera permission before using barcode scanner
/// final status = await PermissionHandler().checkPermission(
///   Permission.camera,//this is the permission you want to check
///   context, //this is the context of the screen you want to check the permission on
///   AppMessage.cameraPermissionRequired,//this is the message you want to show if the permission is denied
/// );
///
/// // If permission granted, proceed with camera functionality
/// if (status && context.mounted) {
///   //do something here
/// }
/// ```
///
/// The [checkPermission] method will:
/// 1. Check current permission status
/// 2. Request permission if not already granted
/// 3. Show settings dialog if permission denied/restricted
/// 4. Return true if permission granted, false otherwise
class PermissionHandler {
  // Private static instance
  static PermissionHandler? _instance;

  // Private constructor
  PermissionHandler._();

  // Factory constructor
  factory PermissionHandler() {
    _instance ??= PermissionHandler._();
    return _instance!;
  }
  Future<bool> checkPermission(
    Permission permission,
    BuildContext context,
    String permissionMessage,
  ) async {
    try {
      final PermissionEnum permissionStatus = await _checkPermissioStatus(
        permission,
      );

      if (permissionStatus == PermissionEnum.allow) {
        return true;
      } else {
        if (permissionStatus == PermissionEnum.permissionDenied ||
            permissionStatus == PermissionEnum.permissionRestricted ||
            permissionStatus == PermissionEnum.permissionPermanentlyDenied) {
          final permsssion = await permission.request();

          if (permsssion == PermissionStatus.granted) {
            return true;
          } else if (permsssion == PermissionStatus.denied ||
              permsssion == PermissionStatus.permanentlyDenied ||
              permsssion == PermissionStatus.restricted ||
              permsssion == PermissionStatus.limited) {
            if (context.mounted) {
              Alert.show<bool>(
                context: context,
                type: AlertType.info,
                title: AppMessage.cameraPermissionRequired,
                onConfirmBtnTap: () async {
                  await openAppSettings();
                  if (context.mounted) {
                    Alert.dismissDialog(context);
                  }
                },
              );
            }
          }
        }
      }
      return false;
    } catch (e) {
      printInfo(e.toString());
      return false;
    }
  }

  Future<PermissionEnum> _checkPermissioStatus(Permission permission) async {
    final PermissionStatus permissionStatus = await permission.status;
    if (permissionStatus.isGranted) {
      return PermissionEnum.allow;
    } else if (permissionStatus.isDenied) {
      return PermissionEnum.permissionDenied;
    } else if (permissionStatus.isRestricted) {
      return PermissionEnum.permissionRestricted;
    } else if (Platform.isIOS || permissionStatus.isPermanentlyDenied) {
      return PermissionEnum.permissionPermanentlyDenied;
    } else {
      return PermissionEnum.unknownPermissionError;
    }
  }
}
