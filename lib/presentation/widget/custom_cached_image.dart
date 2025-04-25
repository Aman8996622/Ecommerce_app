import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? errorImage;
  final BorderRadius? borderRadius;
  static const double dafaultErrorPadding = 5;

  const CustomCacheImage({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
    this.fit,
    this.errorImage,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) => (imageUrl.isNotEmpty)
      ? CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) => Center(
            child: errorImage ?? const Icon(Icons.error_sharp),
          ),
        )
      : SizedBox(
          height: height,
          width: width,
          child: Center(
            child: errorImage ?? const Icon(Icons.error_sharp),
          ),
        );
}
