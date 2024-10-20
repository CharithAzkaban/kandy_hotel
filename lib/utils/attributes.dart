import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kandy_hotel/features/dashboard/dashboard_screen.dart';
import 'package:kandy_hotel/features/deductions/deductions_screen.dart';
import 'package:kandy_hotel/features/inquiry/inquiry_screen.dart';
import 'package:kandy_hotel/features/inventory/inventory_screen.dart';
import 'package:kandy_hotel/features/landing/landing_screen.dart';
import 'package:kandy_hotel/features/returns/returns_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'methods.dart';

double dHeight(BuildContext context) => MediaQuery.of(context).size.height;
double dWidth(BuildContext context) => MediaQuery.of(context).size.width;

final goRouter = GoRouter(
  initialLocation: '/${ets(DashboardScreen.page)}',
  routes: [
    GoRoute(
      path: '/${ets(DashboardScreen.page)}',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/${ets(DeductionsScreen.page)}',
      builder: (context, state) => const DeductionsScreen(),
    ),
    GoRoute(
      path: '/${ets(InquiryScreen.page)}',
      builder: (context, state) => const InquiryScreen(),
    ),
    GoRoute(
      path: '/${ets(InventoryScreen.page)}',
      builder: (context, state) => const InventoryScreen(),
    ),
    GoRoute(
      path: '/${ets(LandingScreen.page)}',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/${ets(ReturnsScreen.page)}',
      builder: (context, state) => const ReturnsScreen(),
    ),
  ],
);

RoundedRectangleBorder rrBorder(
  double radius, {
  BorderSide side = BorderSide.none,
}) =>
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: side,
    );

Future<SharedPreferences> get sPrefs async => await SharedPreferences.getInstance();

final primary = hexColor('#1FAD78');
final secondary = hexColor('#3FDCA2');
final tertiary = hexColor('#C3C3E5');
final special = hexColor('#8C489F');

final error = hexColor('#F44336');
final success = hexColor('#00B300');
final warn = hexColor('#FFA407');

var isSignedIn = false;

final today = DateTime.now();
