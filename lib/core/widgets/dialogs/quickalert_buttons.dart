import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matryal_seller/core/domain/entity/alert_model.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../app_buttons.dart';

class AlertButtons extends StatelessWidget {
  final AlertOptions options;

  const AlertButtons({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        textDirection:
            context.locale.toString() == 'ar'
                ? TextDirection.ltr
                : TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          cancelBtn(context),
          options.type != AlertType.loading
              ? okayBtn(context)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget okayBtn(context) {
    if (!options.showConfirmBtn!) {
      return const SizedBox();
    }
    final showCancelBtn =
        options.type == AlertType.confirm ? true : options.showCancelBtn!;

    final okayBtn = buildButton(
      context: context,
      isOkayBtn: true,
      text: options.confirmBtnText!,
      onTap: () {
        options.timer?.cancel();
        options.onConfirmBtnTap != null
            ? options.onConfirmBtnTap!()
            : Navigator.pop(context);
      },
    );

    if (showCancelBtn) {
      return Expanded(child: okayBtn);
    } else {
      return okayBtn;
    }
  }

  Widget cancelBtn(context) {
    final showCancelBtn =
        options.type == AlertType.confirm ? true : options.showCancelBtn!;

    final cancelBtn = buildButton(
      context: context,
      isOkayBtn: false,
      text: options.cancelBtnText!,
      onTap: () {
        options.timer?.cancel();
        options.onCancelBtnTap != null
            ? options.onCancelBtnTap!()
            : Navigator.pop(context);
      },
    );

    if (showCancelBtn) {
      return Expanded(child: cancelBtn);
    } else {
      return const SizedBox();
    }
  }

  Widget buildButton({
    BuildContext? context,
    required bool isOkayBtn,
    required String text,
    VoidCallback? onTap,
  }) {
    final btnText = Text(text, style: defaultTextStyle(isOkayBtn));
    final okayBtn = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: AppButtons(
        textStyleColor: AppColor.white,
        textStyleWeight: FontWeight.bold,
        onPressed: onTap,
        text: btnText.data ?? '',
        backgroundColor: whatBtColor(),
      ),
    );

    final cancelBtn = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: AppButtons(
        textStyleColor: AppColor.red,
        textStyleWeight: FontWeight.bold,
        onPressed: onTap,
        text: btnText.data ?? '',
        backgroundColor: AppColor.noColor,
        side: BorderSide(color: AppColor.red),
      ),
    );

    return isOkayBtn ? okayBtn : cancelBtn;
  }

  TextStyle defaultTextStyle(bool isOkayBtn) {
    final textStyle = TextStyle(
      color: isOkayBtn ? Colors.white : AppColor.red,
      fontWeight: FontWeight.w600,
      fontSize: AppSize.bodyText,
    );

    if (isOkayBtn) {
      return options.confirmBtnTextStyle ?? textStyle;
    } else {
      return options.cancelBtnTextStyle ?? textStyle;
    }
  }

  Color whatBtColor() {
    switch (options.type) {
      case AlertType.success:
        return AppColor.mainColor;
      case AlertType.error:
        return AppColor.red;
      case AlertType.warning:
        return AppColor.mainColor;
      case AlertType.confirm:
        return AppColor.mainColor;
      case AlertType.info:
        return AppColor.blue;
      case AlertType.custom:
        return AppColor.noColor;
      case AlertType.loading:
        return AppColor.noColor;
    }
  }
}
