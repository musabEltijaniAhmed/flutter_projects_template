import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';


class AppRatingBar extends StatelessWidget {
  final double initialRating;
  final double? itemSize;
  final Function(double rating)? onRating;
  final bool? ignoreGestures;
  final EdgeInsetsGeometry? itemPadding;
  const AppRatingBar({
    super.key,
    required this.initialRating,
    this.itemSize,
    this.onRating,
    this.ignoreGestures,
    this.itemPadding,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGestures ?? true,
      itemSize: itemSize ?? AppSize.smallIconSize,
      initialRating: initialRating,
      unratedColor: AppColor.lightGray,
      allowHalfRating: true,
      maxRating: 5,
      itemBuilder:
          (context, _) => Padding(
            padding: itemPadding ?? EdgeInsets.zero,
            child: Icon(AppIcons.star, color: Colors.amber),
          ),
      onRatingUpdate: (rating) {
        onRating != null ? {onRating!(rating)} : null;
      },
    );
  }
}
