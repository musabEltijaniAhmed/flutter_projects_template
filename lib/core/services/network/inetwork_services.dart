import 'package:matryal_seller/core/domain/entity/data_handel_model.dart';

import '../../domain/entity/file_upload_data.dart';

abstract class INetworkServices {
  ///this class have abstract method using in this layer

  Future<PostDataHandle<T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    bool requiresToken,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<PostDataHandle<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    bool requiresToken = false,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<PostDataHandle<T>> uploadFile<T>({
    required String url,
    Map<String, dynamic>? body,
    bool requiresToken = false,
    List<FileUploadData> files,
    required T Function(Map<String, dynamic>) fromJson,
  });
}
