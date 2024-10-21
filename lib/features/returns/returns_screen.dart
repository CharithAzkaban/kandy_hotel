import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/returns/widgets/return_item.dart';
import 'package:kandy_hotel/providers/return_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/unfocus_wrapper.dart';
import 'package:kandy_hotel/widgets/vaaru_button.dart';
import 'package:kandy_hotel/widgets/vaaru_dropdown.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'widgets/date_range_box.dart';

class ReturnsScreen extends StatefulWidget {
  static const page = Routes.returns;
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  late final ReturnProvider _returnProvider;
  final _yearListener = ValueNotifier<int?>(today.year);
  final _monthListener = ValueNotifier<int?>(today.month);
  final _dateRangeListener = ValueNotifier<PickerDateRange?>(PickerDateRange(DateTime(today.year, today.month, 1), lastDayOfMonth(today)));

  @override
  void initState() {
    super.initState();
    _returnProvider = provider<ReturnProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadReturns());
    _yearListener.addListener(() => _loadReturns());
    _monthListener.addListener(() => _loadReturns());
    _dateRangeListener.addListener(() => _loadReturns());
  }

  @override
  void dispose() {
    _returnProvider.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UnfocusWrapper(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: warn,
            title: const VaaruText('Returns', color: white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: rrBorder(15.0),
                  pinned: true,
                  leading: const Icon(Icons.search_rounded),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150.0,
                          child: ValueListenableBuilder(
                            valueListenable: _yearListener,
                            builder: (context, selectedYear, _) {
                              return VaaruDropDown(
                                value: selectedYear,
                                items: List.generate(7, (index) {
                                  final year = 2024 + index;
                                  return VDDItem(
                                    label: year.toString(),
                                    value: year,
                                    enabled: year <= today.year,
                                  );
                                }),
                                labelText: 'Year',
                                onChanged: (value) => _yearListener.value = value,
                              );
                            },
                          ),
                        ),
                        const Gap(h: 20.0),
                        SizedBox(
                          width: 150.0,
                          child: ValueListenableBuilder(
                            valueListenable: _monthListener,
                            builder: (context, selectedMonth, _) {
                              return VaaruDropDown(
                                value: selectedMonth,
                                items: List.generate(
                                  13,
                                  (index) => VDDItem(
                                    label: months[index],
                                    value: index == 0 ? null : index,
                                    enabled: index <= today.month,
                                  ),
                                ),
                                labelText: 'Month',
                                onChanged: (value) {
                                  _monthListener.value = value;
                                  if (value != null) {
                                    final monthDate = DateTime(_yearListener.value ?? today.year, value);
                                    _dateRangeListener.value = PickerDateRange(monthDate, lastDayOfMonth(monthDate));
                                  } else {
                                    _dateRangeListener.value = null;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const Gap(h: 20.0),
                        MultiValueListenableBuilder(
                          valueListenables: [_yearListener, _monthListener, _dateRangeListener],
                          builder: (context, values, _) {
                            final selectedYear = values[0] as int?;
                            final selectedMonth = values[1] as int?;
                            final selectedDateRange = values[2] as PickerDateRange?;
                            final startDate = selectedDateRange?.startDate;
                            final endDate = selectedDateRange?.endDate;
                            final dateString = selectedDateRange != null ? '${date(startDate)} - ${date(endDate)}' : 'Dates';
                            return VaaruButton(
                              label: dateString,
                              backgroundColor: warn,
                              onPressed: selectedYear != null && selectedMonth != null
                                  ? () {
                                      final monthDate = DateTime(selectedYear, selectedMonth);
                                      popup<PickerDateRange?>(
                                        context,
                                        title: date(monthDate, format: 'MMM yyyy'),
                                        cancelLabel: 'DONE',
                                        cancelColor: blue,
                                        body: DateRangeBox(
                                          monthDate,
                                          onSelected: (range) => _dateRangeListener.value = range,
                                        ),
                                      );
                                    }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<ReturnProvider>(
                  builder: (context, returnData, _) {
                    final returnProducts = returnData.returnProducts;
                    return returnProducts.isNotEmpty
                        ? SliverList.separated(
                            itemBuilder: (context, index) => ReturnItem(returnProducts[index]),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: returnProducts.length,
                          )
                        : SliverToBoxAdapter(
                            child: SizedBox(
                              height: dHeight(context) * 0.8,
                              child: const Center(
                                child: VaaruText('No returns available.'),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      );

  void _loadReturns() => _returnProvider.loadReturns(
        context,
        year: _yearListener.value ?? today.year,
        month: _monthListener.value,
        dateRange: _dateRangeListener.value,
      );
}
