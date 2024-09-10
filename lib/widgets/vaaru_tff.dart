import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandy_hotel/utils/constants.dart';

class VaaruTff extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;
  final String obscuringCharacter = '•';
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool showEye;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? formatters;
  final TextAlign align;
  final double? width;
  const VaaruTff({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.prefixText,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.readOnly = false,
    this.showEye = false,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.formatters,
    this.align = TextAlign.start,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> showPasswordListener = ValueNotifier(false);
    return SizedBox(
      width: width,
      child: ValueListenableBuilder(
        valueListenable: showPasswordListener,
        builder: (context, show, _) => TextFormField(
          cursorColor: grey,
          autofocus: autofocus,
          keyboardType:
              obscureText ? TextInputType.visiblePassword : keyboardType,
          textAlign: align,
          controller: controller,
          readOnly: readOnly,
          initialValue: initialValue,
          obscureText: obscureText && !show,
          focusNode: focusNode,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          enabled: enabled,
          inputFormatters: formatters,
          validator: validator,
          decoration: InputDecoration(
            prefixText: prefixText,
            labelText: labelText,
            labelStyle: const TextStyle(color: grey),
            suffixIcon: obscureText && showEye
                ? IconButton(
                    onPressed: () => showPasswordListener.value = !show,
                    splashRadius: 20.0,
                    icon: Icon(
                      show
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                  )
                : suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              borderSide: BorderSide(
                color: grey,
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16.0,
            ),
            prefixIcon: prefixIcon,
          ),
        ),
      ),
    );
  }
}
