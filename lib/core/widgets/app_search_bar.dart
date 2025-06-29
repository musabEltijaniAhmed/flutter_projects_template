import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

class AppSearchBar extends StatelessWidget {
  final BuildContext context;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(int?)? sortResult;
  final Function()? onSortCancel;
  final ProviderListenable? provider;
  final String? label;
  final bool? enable;
  final void Function()? onTap;
  final List<String>? sortList;
  final bool? withSort;
  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.label,
    this.onTap,
    this.enable,
    this.withSort,
    this.sortList,
    required this.context,
    this.sortResult,
    this.onSortCancel,
    this.provider,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lightGray, width: 0.2),
        borderRadius: BorderRadius.circular(AppSize.cardRadius),
      ),
      height: 45.spMin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: AppTextFields(
              borderColor: AppColor.noColor,
              fillColor: AppColor.noColor,
              focusedColor: AppColor.noColor,
              borderThickness: 0,
              validator: (v) {
                return null;
              },
              onChanged: onChanged,
              onTap: onTap,
              enable: enable ?? true,
              isFocus: false,
              controller: controller,
              textInputAction: TextInputAction.search,
              hintText: label ?? 'search'.tr(),
              inputFormatters: [
                // This formatter allows Arabic and English characters (both upper and lower case),
                // spaces, and digits.
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z\u0600-\u06FF\d\s]'),
                ),
              ],
            ),
          ),
          //filter======================================================================================================================================================
        ],
      ),
    );
  }
}
