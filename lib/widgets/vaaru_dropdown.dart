import 'package:flutter/material.dart';

import 'vaaru_text.dart';

class VaaruDropDown<T> extends StatelessWidget {
  final T? value;
  final List<VDDItem<T>> items;
  final String labelText;
  final String? hintText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final double? width;
  final int? errorMaxLines;
  final bool noErrorText;
  final Color? fillColor;
  final Color? labelColor;
  final bool showBorder;
  const VaaruDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    this.hintText,
    required this.onChanged,
    this.validator,
    this.width,
    this.errorMaxLines,
    this.noErrorText = false,
    this.fillColor,
    this.labelColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        value: value,
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item.value,
                onTap: item.onTap,
                child: VaaruText(item.label),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: validator,
        borderRadius: BorderRadius.circular(7.0),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: showBorder ? const BorderSide() : BorderSide.none,
          ),
          labelStyle: TextStyle(
            color: labelColor,
          ),
          errorMaxLines: errorMaxLines,
          labelText: labelText,
          hintText: hintText,
          errorStyle: noErrorText
              ? const TextStyle(
                  height: 0.0,
                  fontSize: 0.0,
                )
              : null,
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
        ),
      ),
    );
  }
}

class VDDItem<T> {
  final String label;
  final T value;
  final void Function()? onTap;

  VDDItem({
    required this.label,
    required this.value,
    this.onTap,
  });
}
