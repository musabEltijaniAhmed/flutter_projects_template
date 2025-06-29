abstract interface class StateRepository {
  void resetState();
  void loadData({bool? refresh});
}
