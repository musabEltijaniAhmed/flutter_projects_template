class AppFlowState {
  static const String initial = 'initial';
  static const String loading = 'loading';
  static const String loaded = 'loaded';
  static const String notFound = 'notFound';
  static const String loadingMore = 'loading more';
  static const String stopLoading = 'stopLoading';
}

extension AppFlowStateExtension on String {
  bool get isError {
    return ![
      AppFlowState.initial,
      AppFlowState.loading,
      AppFlowState.loaded,
      AppFlowState.notFound,
      AppFlowState.loadingMore,
      AppFlowState.stopLoading,
    ].contains(this);
  }
}
