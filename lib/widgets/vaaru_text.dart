import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/constants.dart';

class VaaruText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final bool oneLine;
  final bool stroke;
  final bool underlined;
  final int? maxLines;
  final double? lGap;
  final double? rGap;
  final String? showMoreText;
  final String? showLessText;
  final int trimLines;
  final void Function()? onTap;

  const VaaruText(
    this.text, {
    super.key,
    this.size,
    this.color,
    this.align,
    this.weight,
    this.overflow,
    this.oneLine = false,
    this.stroke = false,
    this.underlined = false,
    this.maxLines,
    this.lGap,
    this.rGap,
    this.showMoreText,
    this.showLessText,
    this.trimLines = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: lGap ?? 0.0,
          right: rGap ?? 0.0,
        ),
        child: Text(
          text ?? '---',
          textAlign: align ?? TextAlign.center,
          overflow: overflow,
          maxLines: oneLine ? 1 : maxLines,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: weight,
            decoration: underlined
                ? TextDecoration.underline
                : stroke
                    ? TextDecoration.lineThrough
                    : null,
            decorationColor: color ?? black,
            decorationThickness: 2.0,
          ),
        ),
      ),
    );
  }
}
