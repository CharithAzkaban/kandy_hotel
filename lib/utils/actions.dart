import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

import 'attributes.dart';
import 'constants.dart';
import 'enums.dart';
import 'methods.dart';

void cancelDebounce(Debounces tag) => EasyDebounce.cancel(ets(tag));

void confirm(
  BuildContext context, {
  required String confirmMessage,
  required void Function() onConfirm,
  void Function()? onDismiss,
  String confirmLabel = 'CONFIRM',
  String dismissLabel = 'DISMISS',
  Color? confirmColor,
  Color? dismissColor,
}) =>
    popup(
      context,
      careBack: false,
      showCancel: false,
      title: 'CONFIRMATION',
      body: VaaruText(confirmMessage),
      actions: [
        PopupAction(
          label: dismissLabel,
          labelColor: dismissColor ?? error,
          onPressed: () {
            pop(context);
            if (onDismiss != null) onDismiss();
          },
        ),
        PopupAction(
          label: confirmLabel,
          labelColor: confirmColor ?? primary,
          onPressed: () {
            pop(context);
            onConfirm();
          },
        ),
      ],
    );

void debounce(
  Debounces tag, {
  int milliseconds = 500,
  required void Function() onExecute,
}) =>
    EasyDebounce.debounce(
      ets(tag),
      Duration(milliseconds: milliseconds),
      onExecute,
    );

void info(
  BuildContext context, {
  required String infoMessage,
  String okLabel = 'OK',
  StatusTypes type = StatusTypes.INFO,
  void Function()? onOk,
}) =>
    popup(
      context,
      title: ets(type),
      body: VaaruText(infoMessage),
      careBack: onOk == null,
      showCancel: false,
      actions: [
        PopupAction(
          label: okLabel,
          onPressed: () {
            pop(context);
            waitAndDo(300, onOk);
          },
        ),
      ],
    );

void navigate<T>(
  BuildContext context, {
  required Routes route,
  bool replace = false,
  Object? extra,
  void Function(Object?)? onValue,
}) =>
    replace
        ? context.go(
            '/${ets(route)}',
            extra: extra,
          )
        : context
            .push(
              '/${ets(route)}',
              extra: extra,
            )
            .then(onValue ?? (_) {});

void pop<T>(
  BuildContext context, {
  T? result,
}) {
  if (context.canPop()) {
    context.pop(result);
  }
}

Future<T?> popup<T>(
  BuildContext context, {
  required String? title,
  Widget? icon,
  Widget? body,
  bool showActions = true,
  bool showCancel = true,
  String cancelLabel = 'CANCEL',
  List<PopupAction>? actions,
  Color? backgroundColor,
  Color? cancelColor,
  double? elevation,
  bool careBack = true,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: careBack,
      builder: (context) => PopScope(
        canPop: careBack,
        child: AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          titlePadding: const EdgeInsets.all(10.0),
          iconPadding: const EdgeInsets.all(10.0),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: rrBorder(15.0),
          title: title != null ? VaaruText(title) : null,
          content: body,
          icon: icon,
          actions: showActions
              ? [
                  if (showCancel)
                    PopupAction(
                      onPressed: () {},
                      label: cancelLabel,
                      labelColor: cancelColor ?? error,
                    ),
                  ...actions ?? [],
                ]
              : null,
        ),
      ),
    );

void waitAndDo(
  int milliseconds,
  void Function()? doThis,
) =>
    Future.delayed(
      Duration(milliseconds: milliseconds),
      doThis,
    );

void waiting<T>(
  BuildContext context, {
  required Future<T> Function() process,
  void Function(T)? afterProcessed,
  String? waitingMessage,
}) {
  EasyLoading.show(
    status: waitingMessage,
    dismissOnTap: false,
    maskType: EasyLoadingMaskType.black,
  );
  debounce(
    Debounces.LOADING,
    milliseconds: 10000,
    onExecute: () {
      EasyLoading.dismiss();
      cancelDebounce(Debounces.LOADING);
    },
  );
  process().then((result) {
    cancelDebounce(Debounces.LOADING);
    EasyLoading.dismiss();
    if (afterProcessed != null) {
      waitAndDo(
        300,
        () => afterProcessed(result),
      );
    }
  });
}

// <---------- WIDGETS ---------->

class PopupAction extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final void Function()? onPressed;
  final bool manualPop;
  const PopupAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.manualPop = false,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed != null
            ? () {
                if (!manualPop) pop(context);
                onPressed!();
              }
            : null,
        child: VaaruText(
          label,
          weight: FontWeight.bold,
          color: onPressed != null ? (labelColor ?? primary) : grey,
        ),
      );
}
