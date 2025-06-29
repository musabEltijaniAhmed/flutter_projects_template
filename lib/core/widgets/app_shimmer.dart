import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

import '../domain/entity/item_shape_model.dart';

class AppShimmer extends StatelessWidget {
  final List<ItemShape> itemShapeList;
  final CrossAxisAlignment? crossAxisAlignment;

  const AppShimmer({
    super.key,
    required this.itemShapeList,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: AppColor.lightGray.resolveOpacity(0.4),
        highlightColor: AppColor.lightGray,
        direction: ShimmerDirection.rtl,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: itemShapeList.map(_buildItemShape).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItemShape(ItemShape itemShape) {
    if (itemShape.isHorizontalList == true) {
      return _buildHorizontalList(itemShape);
    }
    return _buildNormalShape(itemShape);
  }

  Widget _buildHorizontalList(ItemShape itemShape) {
    return Container(
      height: itemShape.high,
      width: itemShape.width,
      margin: itemShape.horizontalListWidthMargin,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, index) {
          return AspectRatio(
            aspectRatio: itemShape.horizontalListAspectRatio ?? 1.0,
            child: Container(
              margin: itemShape.horizontalListMargin,
              decoration: BoxDecoration(
                borderRadius: itemShape.borderRadius,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNormalShape(ItemShape itemShape) {
    return Container(
      width: itemShape.width,
      height: itemShape.high,
      margin: itemShape.margin,
      decoration: BoxDecoration(
        borderRadius: itemShape.borderRadius,
        color: Colors.white,
        shape: itemShape.shape ?? BoxShape.rectangle,
      ),
    );
  }
}

///use this class to wrap single widget with shimmer
class AppShimmerWidget extends StatelessWidget {
  final Widget child;
  const AppShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.lightGray.resolveOpacity(0.4),
      highlightColor: AppColor.lightGray,
      direction: ShimmerDirection.rtl,
      child: child,
    );
  }
}
