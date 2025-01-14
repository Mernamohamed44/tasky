import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../network/end_points.dart';
import '../utils/colors.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.image,
    this.fit = BoxFit.contain,
    this.height = 200,
    this.width,
    this.filterQuality = FilterQuality.medium,
  });

  final String image;
  final BoxFit fit;
  final double height;
  final double? width;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    String imageUrl = (image.contains("null") ||
            image == "${ApiConstants.baseImagesUrl}/" ||
            image.isEmpty)
        ? "${ApiConstants.baseImagesUrl}/1725699058486-811150837-no-photo.png"
        : image;

    return CachedNetworkImage(
      height: height,
      width: width,
      filterQuality: filterQuality,
      fit: fit,
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(
        color: AppColors.primary,
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error_outline,
        color: AppColors.red,
      ),
    );
  }
}
