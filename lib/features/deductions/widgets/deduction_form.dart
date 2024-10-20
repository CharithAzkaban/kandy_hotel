import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class DeductionForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController amountController;
  const DeductionForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.amountController,
  });

  @override
  State<DeductionForm> createState() => _DeductionFormState();
}

class _DeductionFormState extends State<DeductionForm> {
  final _amountFocus = FocusNode();

  @override
  void dispose() {
    _amountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VaaruTff(
              controller: widget.titleController,
              labelText: 'Subject',
              autofocus: true,
              require: true,
              onFieldSubmitted: (_) => _amountFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.amountController,
              focusNode: _amountFocus,
              labelText: 'Amount',
              prefixText: 'Rs. ',
              require: true,
              onlyDecimals: true,
              onFieldSubmitted: (_) {
                if (widget.formKey.currentState!.validate()) {
                  pop(context, result: true);
                }
              },
            ),
          ],
        ),
      );
}
