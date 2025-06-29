// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// import 'dialogs/quickalert_dialog.dart';
//
// class AppPicker {
//   /// Get file with permission checks
//   static Future<File?> pickFile({
//     required BuildContext context,
//     List<String>? allowedExtensions,
//   }) async {
//     bool isPermissionGranted = await _requestStoragePermission(context);
//
//     // Proceed if permission is granted
//     if (isPermissionGranted) {
//       return await _pickFileFromDevice(allowedExtensions);
//     }
//
//     return null;
//   }
//
//   /// Get image from gallery with permission checks
//   static Future pickImage({required BuildContext context}) async {
//     bool? isPermissionGranted = await _requestPhotoPermission(context);
//
//     // Handle permission denial
//     if (isPermissionGranted == false) {
//       return _showPermissionDeniedDialog(context);
//     }
//
//     return await _pickImageFromGallery();
//   }
//
//   /// Handle permission denial dialog
//   static Future<void> _showPermissionDeniedDialog(BuildContext context) async {
//     return Alert.show(
//         context: context,
//         type: AlertType.error,
//         message: LocaleKeys.accessImage.tr());
//   }
//
//   /// Request storage permission for file access
//   static Future<bool> _requestStoragePermission(BuildContext context) async {
//     if (Platform.isIOS) {
//       final permissionStatus = await Permission.storage.status;
//       if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
//         return await Permission.storage.request().isGranted;
//       }
//       return true;
//     }
//
//     if (Platform.isAndroid) {
//       var device = await DeviceInfoPlugin().androidInfo;
//       if (device.version.sdkInt < 33) {
//         final permissionStatus = await Permission.storage.status;
//         if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
//           return await Permission.storage.request().isGranted;
//         }
//       }
//       return true;
//     }
//     return false;
//   }
//
//   /// Request photo permission for accessing the gallery
//   static Future<bool?> _requestPhotoPermission(BuildContext context) async {
//     try {
//       if (Platform.isIOS) {
//         return await _handleIOSPhotoPermission();
//       } else if (Platform.isAndroid) {
//         return await _handleAndroidPhotoPermission();
//       }
//     } catch (e) {
//       printInfo('Error checking photo roles: $e');
//       return null;
//     }
//     return null;
//   }
//
//   /// Handle photo permission request for iOS
//   static Future<bool?> _handleIOSPhotoPermission() async {
//     final permissionStatus = await Permission.photos.status;
//     if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
//       var result = await Permission.photos.request();
//       return result.isGranted;
//     }
//     return true;
//   }
//
//   /// Handle photo permission request for Android
//   static Future<bool?> _handleAndroidPhotoPermission() async {
//     var device = await DeviceInfoPlugin().androidInfo;
//     if (device.version.sdkInt < 33) {
//       final permissionStatus = await Permission.storage.status;
//       if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
//         var result = await Permission.storage.request();
//         return result.isGranted;
//       }
//     }
//     return true;
//   }
//
//   /// Pick a file using file picker
//   static Future<File?> _pickFileFromDevice(
//       List<String>? allowedExtensions) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       allowedExtensions: allowedExtensions ?? ['pdf'],
//     );
//
//     if (result != null) {
//       return File(result.files.single.path!);
//     }
//
//     return null;
//   }
//
//   /// Pick an image from the gallery
//   static Future<File?> _pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//
//     return null;
//   }
//
//   /// Crop an image file and return the cropped file
//   static Future<File?> cropImage(File image) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       compressFormat: ImageCompressFormat.jpg,
//       compressQuality: 100,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Cropper',
//           toolbarColor: AppColor.mainColor,
//           toolbarWidgetColor: AppColor.white,
//           activeControlsWidgetColor: AppColor.mainColor,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(title: 'Cropper'),
//       ],
//     );
//
//     return croppedFile != null ? File(croppedFile.path) : null;
//   }
//
//   /// Request and handle microphone permission
//   static Future<String?> requestRecordPermission(
//       {required BuildContext context}) async {
//     PermissionStatus permissionStatus = await Permission.microphone.request();
//     if (permissionStatus.isGranted) {
//       return AppConstants.isGranted;
//     } else if (permissionStatus.isPermanentlyDenied) {
//       Alert.show(
//           context: context,
//           type: AlertType.error,
//           title: LocaleKeys.micPermission.tr(),
//           message: LocaleKeys.micPermissionMessage.tr());
//     }
//     return null;
//   }
// }
