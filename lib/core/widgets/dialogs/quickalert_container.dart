import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_project_template/core/widgets/dialogs/quickalert_buttons.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

import '../../domain/entity/alert_model.dart';

class QuickAlertContainer extends StatefulWidget {
  final AlertOptions options;

  const QuickAlertContainer({super.key, required this.options});

  @override
  State<QuickAlertContainer> createState() => _QuickAlertContainerState();
}

class _QuickAlertContainerState extends State<QuickAlertContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);

    ///run animation unit end without repeating
    ///then await 2 scone and open anther page
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final header = buildHeader(context);
    final title = buildTitle(context);
    final text = buildText(context);
    final buttons = buildButtons();
    final childWidget = buildWidget(context);

    final content = Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title,
          SizedBox(height: 5.0.h),
          Flexible(flex: 3, child: text),
          SizedBox(height: 10.0.h),
          childWidget!,
          buttons,
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widget.options.backgroundColor,
        borderRadius: BorderRadius.circular(widget.options.borderRadius!),
      ),
      clipBehavior: Clip.antiAlias,
      width: widget.options.width ?? MediaQuery.of(context).size.shortestSide,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [header, content],
      ),
    );
  }

  Widget buildHeader(context) {
    String? anim = Assets.lottieInfo;
    switch (widget.options.type) {
      case AlertType.success:
        anim = Assets.lottieConfirm;
        break;
      case AlertType.error:
        anim = Assets.lottieError;
        break;
      case AlertType.warning:
        anim = Assets.lottieWarning;
        break;
      case AlertType.confirm:
        anim = Assets.lottieWarning;
        break;
      case AlertType.info:
        anim = Assets.lottieInfo;
        break;
      case AlertType.loading:
        anim = Assets.lottieLoading;
        break;
      default:
        anim = Assets.lottieInfo;
        break;
    }

    if (widget.options.customAsset != null) {
      anim = widget.options.customAsset;
    }

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(color: whatColor()),
      child: SizedBox(
        height: 55.h,
        child: Lottie.asset(
          '$anim',
          controller: animationController,
          onLoaded: (lottieComposition) async {
            await Future.delayed(const Duration(milliseconds: 200));

            ///star animation
            animationController.duration = lottieComposition.duration;
            animationController.forward();
          },
        ),
      ),
    );
  }

  Widget buildTitle(context) {
    final title = widget.options.title ?? whatTitle();
    return Visibility(
      visible: title != null,
      child: AppText(
        text: '$title',
        fontSize: AppSize.bodyText,
        fontWeight: FontWeight.bold,
        align: widget.options.titleAlignment ?? TextAlign.center,
        color: widget.options.titleColor,
      ),
    );
  }

  Widget buildText(context) {
    if (widget.options.message == null &&
        widget.options.type != AlertType.loading) {
      return Container();
    } else {
      String? text = '';
      if (widget.options.type == AlertType.loading) {
        text = widget.options.message ?? AppMessage.loadingText;
      } else {
        text = widget.options.message;
      }
      return AppText(
        text: text ?? '',
        fontSize: AppSize.smallText,
        align: widget.options.textAlignment ?? TextAlign.center,
        color: widget.options.textColor,
        overflow: TextOverflow.visible,
      );
    }
  }

  Widget? buildWidget(context) {
    if (widget.options.child == null &&
        widget.options.type != AlertType.custom) {
      return Container();
    } else {
      Widget widget_ = Container();
      if (widget.options.type == AlertType.custom) {
        widget_ = widget.options.child ?? widget_;
      }
      return widget.options.child;
    }
  }

  Widget buildButtons() {
    return AlertButtons(options: widget.options);
  }

  String? whatTitle() {
    switch (widget.options.type) {
      case AlertType.success:
        return AppMessage.success;
      case AlertType.error:
        return AppMessage.error;
      case AlertType.warning:
        return AppMessage.warning;
      case AlertType.confirm:
        return AppMessage.confirmation;
      case AlertType.info:
        return AppMessage.info;
      case AlertType.custom:
        return null;
      case AlertType.loading:
        return null;
    }
  }

  Color? whatColor() {
    switch (widget.options.type) {
      case AlertType.success:
        return AppColor.green;
      case AlertType.error:
        return AppColor.red.resolveOpacity(0.3);
      case AlertType.warning:
        return AppColor.mainColor.resolveOpacity(0.3);
      case AlertType.confirm:
        return AppColor.mainColor.resolveOpacity(0.3);
      case AlertType.info:
        return AppColor.blue.resolveOpacity(0.3);
      case AlertType.custom:
        return null;
      case AlertType.loading:
        return null;
    }
  }
}
