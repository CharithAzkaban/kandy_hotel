import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/enums.dart';

class AssetsImage extends StatelessWidget {
  final Images en;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? radius;
  final EdgeInsets padding;

  const AssetsImage(
    this.en, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.radius,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: padding,
      child: radius != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius!),
              child: Image.asset(
                'assets/images/${en.name}.png',
                height: height,
                width: width,
                fit: fit,
              ),
            )
          : Image.asset(
              'assets/images/${en.name}.png',
              height: height,
              width: width,
              fit: fit,
            ),
    );
  }
}