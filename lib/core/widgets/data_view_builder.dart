import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_flow_sate.dart';
import '../constants/app_string.dart';
import '../domain/entity/data_handel_model.dart';
import '../error/app_error_message.dart';
import '../error/app_error_state.dart';
import '../error/handle_api_exception.dart';
import 'app_buttons.dart';
import 'app_refresh_indicator.dart';
import 'helpers.dart';

class DataViewBuilder<T> extends StatelessWidget {
  final DataHandle<T> dataHandle;
  final Widget Function() loadingBuilder;
  final Widget Function(T data) successBuilder;
  final bool Function() isDataEmpty;
  final Future<void> Function() onReload;
  final bool showAppBar;
  final bool isSmallError;
  final Decoration? decoration;
  final double? errorImageHeight;
  final Color? scaffoldColor;

  const DataViewBuilder({
    super.key,
    required this.dataHandle,
    required this.loadingBuilder,
    required this.successBuilder,
    required this.isDataEmpty,
    required this.onReload,
    this.showAppBar = false,
    this.decoration,
    this.errorImageHeight,
    this.scaffoldColor,
    this.isSmallError = false,
  });

  @override
  Widget build(BuildContext context) {
    final result = dataHandle.result;

    ///om loading or initial show shimmer=======================================================================================================================
    if (result == AppFlowState.loading || result == AppFlowState.initial) {
      return loadingBuilder();
    }
    ///on token error=======================================================================================================================================
    else if (result == AppErrorState.unAuthorized) {
      return AppHelpers.unAuthorize(context);
    }
    ///on successful or pagination show data=============================================================================================================================================
    else if (result == AppFlowState.loaded ||
        result == AppFlowState.loadingMore) {
      if (isDataEmpty()) {
        return AppHelpers.emptyData();
      }
      return AppRefreshIndicator(
        onRefresh: onReload,
        child: successBuilder(dataHandle.data as T),
      );
    }

    ///on error show retry button=============================================================================================================================================
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: HandleApiExceptions(
        showAppBar: showAppBar,
        decoration: decoration,
        errorImageHeight: errorImageHeight,
        scaffoldColor: scaffoldColor,
        isSmallError: isSmallError,
        onRefresh: onReload,
        message: AppErrorMessage.getMessage(result),
        child: AppButtons(
          text: AppMessage.tryAgain,
          height: 40.h,
          onPressed: onReload,
        ),
      ),
    );
  }
}
