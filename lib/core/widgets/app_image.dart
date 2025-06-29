import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ColorFilter? colorFilter;
  final BorderRadiusGeometry? borderRadius;
  final bool fromNet;

  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.colorFilter,
    this.fromNet = true,
  });

  /// Named constructor for background image usage
  const AppImage.background({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.colorFilter,
    this.fromNet = true,
  });

  /// Resolves correct ImageProvider based on `fromNet`
  ImageProvider get imageProvider =>
      fromNet ? NetworkImage(image) : AssetImage(image) as ImageProvider;

  /// Builds the FadeInImage widget with placeholder and error handling
  Widget _buildFadeInImage() {
    return FadeInImage(
      height: height ?? 190,
      width: width ?? double.infinity,
      image: imageProvider,
      placeholder: AppHelpers.placeholderImage(image: Assets.imagesHolder),
      placeholderFit: BoxFit.contain,
      imageErrorBuilder:
          (context, error, stackTrace) => AppHelpers.imageError(),
      fit: fit ?? BoxFit.cover,
    );
  }

  /// Exposes ImageProvider (for background use in containers etc.)
  ImageProvider backgroundImage() => imageProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: ColorFiltered(
        colorFilter:
            colorFilter ??
            const ColorFilter.mode(AppColor.noColor, BlendMode.darken),
        child: _buildFadeInImage(),
      ),
    );
  }
}

class AppCashImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxFit? placeHolderFit;
  final ColorFilter? colorFilter;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const AppCashImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.colorFilter,
    this.placeHolderFit,
    this.child,
  });

  /// Named constructor for background widget use
  factory AppCashImage.background({
    required String imageUrl,
    double? height,
    double? width,
    BoxFit? fit,
    BoxFit? placeHolderFit,
    BorderRadiusGeometry? borderRadius,
    Widget? child,
    ColorFilter? colorFilter,
  }) {
    return AppCashImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeHolderFit: placeHolderFit,
      borderRadius: borderRadius,
      colorFilter: colorFilter,
      child: child,
    );
  }

  /// Expose ImageProvider for use in BoxDecoration
  ImageProvider<Object> get backgroundProvider =>
      CachedNetworkImageProvider(imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      child: ColorFiltered(
        colorFilter:
            colorFilter ??
            ColorFilter.mode(Colors.black.resolveOpacity(0), BlendMode.darken),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder:
              (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.lightGray.resolveOpacity(0.26),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
                child: child,
              ),
          placeholder:
              (context, url) =>
                  AppHelpers.placeholderCashNetwork(fit: placeHolderFit),
          errorWidget:
              (context, url, error) =>
                  AppHelpers.placeholderCashNetwork(fit: placeHolderFit),
        ),
      ),
    );
  }
}
