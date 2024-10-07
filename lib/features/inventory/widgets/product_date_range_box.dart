import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProductDateRangeBox extends StatelessWidget {
  final void Function(PickerDateRange?) onSelected;
  const ProductDateRangeBox({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 300.0,
        height: 300.0,
        child: SfDateRangePicker(
          maxDate: today,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionMode: DateRangePickerSelectionMode.range,
          headerStyle: const DateRangePickerHeaderStyle(
            backgroundColor: transparent,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: 'EEE',
            viewHeaderStyle: DateRangePickerViewHeaderStyle(textStyle: TextStyle(fontWeight: FontWeight.bold)),
          ),
          onSelectionChanged: (args) => debounce(
            Debounces.PICK_DATE,
            onExecute: () => onSelected(args.value),
          ),
        ),
      );
}
