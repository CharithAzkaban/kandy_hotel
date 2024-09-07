import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';

class VaaruIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final Color? color;
  final bool mini;
  final bool showBulb;
  final bool filled;
  final Color? bulbColor;
  const VaaruIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
    this.color,
    this.mini = false,
    this.showBulb = false,
    this.filled = false,
    this.bulbColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        filled
            ? IconButton.filled(
                onPressed: onPressed,
                splashColor: Colors.grey,
                splashRadius: mini ? 10.0 : 20.0,
                icon: Icon(
                  icon,
                  size: mini ? 20.0 : 24.0,
                  color: white,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: color,
                ),
              )
            : IconButton(
                onPressed: onPressed,
                splashColor: Colors.grey,
                splashRadius: mini ? 10.0 : 20.0,
                icon: Icon(
                  icon,
                  size: mini ? 20.0 : 24.0,
                  color:
                      onPressed != null ? (color ?? Colors.black) : Colors.grey,
                ),
              ),
        if (showBulb)
          Icon(
            Icons.circle,
            size: 10.0,
            color: bulbColor ?? error,
          ),
      ],
    );
  }
}
