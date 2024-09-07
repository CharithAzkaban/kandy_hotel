import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/attributes.dart';

import 'gap.dart';
import 'vaaru_text.dart';

class VaaruTextButton extends StatelessWidget {
  final String label;
  final double? size;
  final void Function()? onPressed;
  final AlignmentGeometry? alignment;
  final bool underlined;
  final IconData? icon;
  final Color? color;
  final FontWeight? weight;
  final bool leftIcon;
  final TextOverflow? overflow;
  final bool scroll;
  final bool useExpanded;
  final bool oneLine;
  final TextAlign? align;
  final int? maxLines;
  const VaaruTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
    this.alignment,
    this.underlined = false,
    this.icon,
    this.color,
    this.weight,
    this.leftIcon = true,
    this.overflow,
    this.scroll = false,
    this.useExpanded = false,
    this.oneLine = false,
    this.align,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = onPressed!=null ? color ?? primary : Colors.grey;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && leftIcon) Icon(icon!, color: buttonColor),
          if (icon != null && leftIcon) const Gap(h: 3.0),
          useExpanded
              ? Expanded(
                  child: VaaruText(
                    label,
                    align: align,
                    color: buttonColor,
                    size: size,
                    weight: weight,
                    underlined: underlined,
                    overflow: overflow,
                    oneLine: oneLine,
                    maxLines: maxLines,
                  ),
                )
              : VaaruText(
                  label,
                  align: align,
                  color: buttonColor,
                  size: size,
                  weight: weight,
                  underlined: underlined,
                  overflow: overflow,
                  oneLine: oneLine,
                  maxLines: maxLines,
                ),
          if (icon != null && !leftIcon) const Gap(h: 3.0),
          if (icon != null && !leftIcon) Icon(icon!, color: buttonColor),
        ],
      ),
    );
  }
}