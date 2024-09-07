import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kandy_hotel/features/landing/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'methods.dart';

double dHeight(BuildContext context) => MediaQuery.of(context).size.height;
double dWidth(BuildContext context) => MediaQuery.of(context).size.width;

final goRouter = GoRouter(
  initialLocation: '/${ets(LandingScreen.page)}',
  routes: [
    GoRoute(
      path: '/${ets(LandingScreen.page)}',
      builder: (context, state) => const LandingScreen(),
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

Future<SharedPreferences> get sPrefs async =>
    await SharedPreferences.getInstance();

final primary = hexColor('#1FAD78');
final secondary = hexColor('#3FDCA2');
final tertiary = hexColor('#C3C3E5');
final special = hexColor('#8C489F');

final error = hexColor('#F44336');
final success = hexColor('#00B300');
final warn = hexColor('#FFA407');

var isSignedIn = false;
