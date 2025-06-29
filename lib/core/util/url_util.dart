import '../constants/app_end_points.dart';

class UrlUtils {
  ///make class singleton

  static final UrlUtils _instance = UrlUtils._internal();
  factory UrlUtils() => _instance;
  UrlUtils._internal();

  ///check url
  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasAbsolutePath &&
        uri.hasScheme &&
        uri.host.isNotEmpty;
  }

  getImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return 'ApiEndPoints.defaultImage';
    } else if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return imageUrl;
    } else {
      return ApiEndPoints.appDomain + imageUrl;
    }
  }

  //====================================================================================================================================================================
  String? mergeUrl({required String? url}) {
    if (url == null) {
      return null;
    } else if (url.startsWith('/')) {
      return ApiEndPoints.appDomain + url;
    } else {
      return url;
    }
  }
}
