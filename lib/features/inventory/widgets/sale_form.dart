import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class SaleForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final double total;
  final TextEditingController discountController;
  const SaleForm({
    super.key,
    required this.formKey,
    required this.total,
    required this.discountController,
  });

  @override
  State<SaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  final _discountFocus = FocusNode();
  final _cohController = TextEditingController();
  final _balanceListener = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _cohController.addListener(() {
      final cohText = _cohController.text.trim();
      final discountText = widget.discountController.text.trim();
      final coh = onlyNumbers(cohText) ? double.parse(cohText) : 0.0;
      final discount = onlyNumbers(discountText) ? double.parse(discountText) : 0.0;
      _balanceListener.value = coh - widget.total + discount;
    });
    widget.discountController.addListener(() {
      final cohText = _cohController.text.trim();
      final discountText = widget.discountController.text.trim();
      final coh = onlyNumbers(cohText) ? double.parse(cohText) : 0.0;
      final discount = onlyNumbers(discountText) ? double.parse(discountText) : 0.0;
      _balanceListener.value = coh - widget.total + discount;
    });
  }

  @override
  void dispose() {
    _cohController.dispose();
    _discountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VaaruText(
              price(widget.total),
              size: 25.0,
              weight: FontWeight.bold,
            ),
            const Divider(),
            VaaruTff(
              controller: _cohController,
              autofocus: true,
              onlyDecimals: true,
              labelText: 'Cash on hand',
              prefixText: 'Rs. ',
              onFieldSubmitted: (_) => _discountFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.discountController,
              focusNode: _discountFocus,
              onlyDecimals: true,
              labelText: 'Discount',
              prefixText: 'Rs. ',
              onFieldSubmitted: (_) {
                if (widget.formKey.currentState!.validate()) {
                  pop(context, result: true);
                }
              },
            ),
            const Gap(v: 10.0),
            const Divider(height: 5.0),
            ValueListenableBuilder(
              valueListenable: _balanceListener,
              builder: (context, balance, _) => VaaruText(
                price(balance),
                size: 20.0,
                color: balance < 0
                    ? error
                    : balance > 0
                        ? success
                        : null,
                weight: FontWeight.bold,
              ),
            ),
            const Divider(height: 5.0),
            const Divider(height: 5.0),
          ],
        ),
      );
}
