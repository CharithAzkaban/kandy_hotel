import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'attributes.dart';
import 'enums.dart';

bool areSameDates(DateTime? date1, DateTime? date2) => date1 != null && date2 != null && date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

Widget assetImage(
  Images image, {
  double? width,
  double? height,
  BoxFit? fit,
  double? radius,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    Padding(
      padding: padding,
      child: radius == null
          ? Image.asset(
              'assets/images/${ets(image)}.png',
              height: height,
              width: width,
              fit: fit,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset(
                'assets/images/${ets(image)}.png',
                height: height,
                width: width,
                fit: fit,
              ),
            ),
    );

String date(DateTime? date, {String format = 'dd MMM yyyy'}) => date != null ? DateFormat(format).format(date.toLocal()) : '---';

bool equals<T>(T? content1, T? content2) => content1 == content2;

String ets(
  Enum en, {
  bool lower = false,
}) =>
    lower ? en.name.toLowerCase() : en.name;

Future<bool?> getPrefBool(Prefs key) => sPrefs.then((prefs) => prefs.getBool(ets(key)));

Future<int?> getPrefInt(Prefs key) => sPrefs.then((prefs) => prefs.getInt(ets(key)));

Future<String?> getPrefString(Prefs key) => sPrefs.then((prefs) => prefs.getString(ets(key)));

Color hexColor(String code) => HexColor(code);

DateTime lastDayOfMonth(DateTime monthDate) => DateTime(monthDate.year, monthDate.month + 1, 1).subtract(const Duration(days: 1));

String number(
  num number, {
  String? unit,
  String? pluralUnit,
  int? doubleFix,
  bool isAre = false,
  bool zeroAsNo = false,
}) {
  final isOrAre = isAre
      ? number == 1
          ? ' is'
          : number > 1
              ? ' are'
              : ''
      : '';
  final intNumber = number.toInt();
  return number == intNumber && doubleFix == null ? '${zeroAsNo && intNumber == 0 ? 'No' : intNumber.toString()}${unit == null ? '' : ' ${number == 1 ? unit : pluralUnit ?? '${unit}s'}'}$isOrAre' : '${doubleFix != null ? number.toStringAsFixed(doubleFix) : number.toString()}${unit == null ? '' : ' ${number == 1 ? unit : pluralUnit ?? '${unit}s'}'}$isOrAre';
}

bool onlyNumbers(String? text) {
  final pattern = RegExp(r'^[1-9]\d*(\.\d+)?$');
  return pattern.hasMatch(textOrEmpty(text));
}

Future<Box<T>> openHiveBox<T extends HiveObject>(Boxes box) => Hive.openBox<T>(ets(box));

String price(num value) => MoneyFormatter(
      amount: value.toDouble(),
      settings: MoneyFormatterSettings(
        symbol: 'Rs',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: '.',
        fractionDigits: 2,
        compactFormatType: CompactFormatType.short,
      ),
    ).output.symbolOnLeft;

ChangeNotifier provider<ChangeNotifier>(BuildContext context) => context.read<ChangeNotifier>();

Future<bool> setPref({
  required Prefs prefKey,
  required dynamic prefValue,
}) async {
  final pref = await sPrefs;
  if (prefValue is int) {
    return pref.setInt(ets(prefKey), prefValue);
  }
  if (prefValue is bool) {
    return pref.setBool(ets(prefKey), prefValue);
  }
  if (prefValue is double) {
    return pref.setDouble(ets(prefKey), prefValue);
  }
  if (prefValue is String) {
    return pref.setString(ets(prefKey), prefValue);
  }
  return false;
}

B switchValue<A, B>({
  required A switcher,
  required Map<A, B> valueMap,
}) {
  A? selectedKey;
  for (final key in valueMap.keys) {
    if (key == switcher) {
      selectedKey = key;
      break;
    }
  }
  return valueMap[selectedKey] as B;
}

B? switchValueOrNull<A, B>({
  required A swicher,
  required Map<A, B> valueMap,
}) {
  A? selectedKey;
  for (final key in valueMap.keys) {
    if (equals(key, swicher)) {
      selectedKey = key;
      break;
    }
  }
  return valueMap[selectedKey];
}

String textOrEmpty(String? text) => (text == null || text.trim().isEmpty) ? '' : text.trim();
String? textOrNull(String? text) => (text == null || text.trim().isEmpty) ? null : text.trim();

void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

String uuid() => const Uuid().v1();

// Temp
void pp(
  Object? object, {
  String label = '',
}) =>
    // ignore: avoid_print
    print('================================>$label $object');
