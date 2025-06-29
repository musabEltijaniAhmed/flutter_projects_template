class ApiEndPoints {
  static const String _appDomain = 'https://ozcco.khuzam.io';
  static get appDomain => _appDomain;
  static const String _auth = '/api/v1/auth';
  static const String _project = '/api/v1/project';
  static const String _products = '/api/v1/products';
  static const String authUrl = '$_appDomain$_auth/login';
  static const String projectUrl = '$_appDomain$_project';
  static const String productsUrl = '$_appDomain$_products';

  /// Store settings endpoints
  static const String storeSettingsUrl = '/store/settings';

  // Payments endpoints
  static const String paymentsHistoryUrl = '/payments/history';
}
