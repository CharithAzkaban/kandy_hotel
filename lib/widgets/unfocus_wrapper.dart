import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/methods.dart';

class UnfocusWrapper extends StatelessWidget {
  final Widget child;
  const UnfocusWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocus,
      child: child,
    );
  }
}
