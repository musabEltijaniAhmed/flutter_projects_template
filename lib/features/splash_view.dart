import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/widgets/app_text.dart';
import 'package:flutter_project_template/core/widgets/helpers.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    //check if user is login or not
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: AppSize.screenHeight,
        width: AppSize.screenWidth,
        color: AppColor.mainColor,
        child: AppText(
          text: AppMessage.appName,
          color: AppColor.white,
          fontSize: AppSize.bodyText,
        ),
      ),
    );
  }
}
