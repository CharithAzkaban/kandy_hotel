import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeBox extends StatelessWidget {
  final DateTime monthDate;
  final void Function(PickerDateRange?) onSelected;
  const DateRangeBox(
    this.monthDate, {
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 300.0,
        height: 300.0,
        child: SfDateRangePicker(
          minDate: monthDate,
          maxDate: lastDayOfMonth(monthDate),
          selectionShape: DateRangePickerSelectionShape.rectangle,
          selectionMode: DateRangePickerSelectionMode.range,
          headerHeight: 0.0,
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
