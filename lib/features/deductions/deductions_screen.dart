import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/deductions/widgets/deduction_form.dart';
import 'package:kandy_hotel/features/deductions/widgets/deduction_item.dart';
import 'package:kandy_hotel/providers/deduction_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/popup_action.dart';
import 'package:kandy_hotel/widgets/unfocus_wrapper.dart';
import 'package:kandy_hotel/widgets/vaaru_button.dart';
import 'package:kandy_hotel/widgets/vaaru_dropdown.dart';
import 'package:kandy_hotel/widgets/vaaru_icon_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'widgets/date_range_box.dart';

class DeductionsScreen extends StatefulWidget {
  static const page = Routes.deductions;
  const DeductionsScreen({super.key});

  @override
  State<DeductionsScreen> createState() => _DeductionsScreenState();
}

class _DeductionsScreenState extends State<DeductionsScreen> {
  late final DeductionProvider _deductionProvider;
  final _yearListener = ValueNotifier<int?>(today.year);
  final _monthListener = ValueNotifier<int?>(today.month);
  final _dateRangeListener = ValueNotifier<PickerDateRange?>(PickerDateRange(DateTime(today.year, today.month, 1), lastDayOfMonth(today)));

  @override
  void initState() {
    super.initState();
    _deductionProvider = provider<DeductionProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDeductions());
    _yearListener.addListener(() => _loadDeductions());
    _monthListener.addListener(() => _loadDeductions());
    _dateRangeListener.addListener(() => _loadDeductions());
  }

  @override
  void dispose() {
    _deductionProvider.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UnfocusWrapper(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: error,
            title: const VaaruText('Deductions', color: white),
            actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: VaaruIconButton(
                icon: Icons.add_rounded,
                color: white,
                onPressed: () => _addDeduction(context),
              ),
            ),
          ],
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
                              backgroundColor: error,
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
                  actions: [
                    Consumer<DeductionProvider>(builder: (context, deductionData, _) {
                      final deductions = deductionData.deductions;
                      final total = deductions.fold(0.0, (subTotal, deduction) => subTotal + deduction.amount);
                      return Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: VaaruText(
                          'Total Deductions: ${price(total)}',
                          color: error,
                          size: 18.0,
                          weight: FontWeight.bold,
                        ),
                      );
                    })
                  ],
                ),
                Consumer<DeductionProvider>(
                  builder: (context, deductionData, _) {
                    final deductions = deductionData.deductions;
                    return deductions.isNotEmpty
                        ? SliverList.separated(
                            itemBuilder: (context, index) => DeductionItem(deductions[index]),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: deductions.length,
                          )
                        : SliverToBoxAdapter(
                            child: SizedBox(
                              height: dHeight(context) * 0.8,
                              child: const Center(
                                child: VaaruText('No sales available.'),
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

  void _loadDeductions() => _deductionProvider.loadDeductions(
        context,
        year: _yearListener.value ?? today.year,
        month: _monthListener.value,
        dateRange: _dateRangeListener.value,
      );

  void _addDeduction(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    popup<bool>(
      context,
      title: 'Add Deduction',
      cancelLabel: 'DISMISS',
      body: DeductionForm(
        formKey: formKey,
        titleController: titleController,
        amountController: amountController,
      ),
      actions: [
        PopupAction(
          label: 'ADD',
          validationKey: formKey,
          popResult: true,
        ),
      ],
      onValue: (isOk) {
        if (isOk != null && isOk && context.mounted) {
          _deductionProvider.addDeduction(
            context,
            title: titleController.text.trim(),
            amount: double.parse(amountController.text.trim()),
          );
        }
        return null;
      },
    );
  }
}
