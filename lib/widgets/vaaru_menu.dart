import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/constants.dart';

import 'vaaru_text.dart';

class VaaruMenu<T> extends StatelessWidget {
  final List<VaaruMenuItem<T>> items;
  final void Function(T)? onSelected;
  final String? tooltip;
  final Widget? icon;
  final Color? fillColor;
  const VaaruMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.tooltip,
    this.icon,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) => PopupMenuButton<T>(
        onSelected: onSelected,
        iconColor: white,
        tooltip: tooltip,
        icon: icon,
        style: IconButton.styleFrom(backgroundColor: fillColor),
        itemBuilder: (context) => items
            .map((item) => PopupMenuItem(
                  value: item.value,
                  enabled: item.enabled,
                  child: ListTile(
                    title: VaaruText(
                      item.label,
                      color: item.color,
                      align: TextAlign.left,
                    ),
                    subtitle: item.subLabel != null
                        ? VaaruText(
                            item.subLabel,
                            align: TextAlign.left,
                            size: 12.0,
                            color: grey,
                          )
                        : null,
                  ),
                ))
            .toList(),
      );
}

class VaaruMenuItem<T> {
  final T value;
  final String label;
  final String? subLabel;
  final Color? color;
  final bool enabled;

  const VaaruMenuItem({
    required this.value,
    required this.label,
    this.subLabel,
    this.color,
    this.enabled = true,
  });
}
