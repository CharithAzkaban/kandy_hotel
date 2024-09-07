import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double? h;
  final double? v;
  const Gap({super.key, this.h, this.v});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: h,
      height: v,
    );
  }
}