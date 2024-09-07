import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';

import 'vaaru_text.dart';

class VaaruButton extends StatelessWidget {
  final String label;
  final FutureOr Function()? onPressed;
  final double? width;
  final double? height;
  final double? hGap;
  final bool elevated;
  final bool rounded;
  final bool outlined;
  final Color? backgroundColor;
  const VaaruButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.hGap,
    this.elevated = true,
    this.rounded = false,
    this.outlined = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: width,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  elevation: !elevated ? 0.0 : null,
                  shape: rrBorder(rounded ? 25.0 : 7.0),
                  side: BorderSide(color: backgroundColor ?? primary)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hGap ?? 5.0),
                child: VaaruText(
                  label,
                  color: backgroundColor ?? primary,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? primary,
                elevation: !elevated ? 0.0 : null,
                shape: rrBorder(rounded ? 25.0 : 7.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hGap ?? 5.0),
                child: VaaruText(
                  label,
                  color: white,
                ),
              ),
            ),
    );
  }
}
