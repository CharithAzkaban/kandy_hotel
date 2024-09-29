import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';

import 'vaaru_text.dart';

class PopupAction<T> extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final void Function()? onPressed;
  final GlobalKey<FormState>? validationKey;
  final T? popResult;
  const PopupAction({
    super.key,
    required this.label,
    this.onPressed,
    this.validationKey,
    this.labelColor,
    this.popResult,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed != null
            ? () {
                if (validationKey != null) {
                  if (validationKey!.currentState!.validate()) {
                    pop(context, result: popResult);
                    waitAndDo(300, onPressed);
                  }
                } else {
                  pop(context, result: popResult);
                  waitAndDo(300, onPressed);
                }
              }
            : () => pop(context, result: popResult),
        child: VaaruText(
          label,
          weight: FontWeight.bold,
          color: labelColor ?? primary,
        ),
      );
}
