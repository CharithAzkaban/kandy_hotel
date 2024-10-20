import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/deductions/deductions_screen.dart';
import 'package:kandy_hotel/features/inquiry/inquiry_screen.dart';
import 'package:kandy_hotel/features/inventory/inventory_screen.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/services/system_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/assets_image.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class DashboardScreen extends StatefulWidget {
  static const page = Routes.dashboard;
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => provider<ProductProvider>(context).loadProducts(context));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: VaaruButton(
          label: 'CHECK FOR UPDATES',
          onPressed: () => checkForUpdates(),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const AssetsImage(
              Images.background,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => navigate(
                            context,
                            route: InventoryScreen.page,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Card(
                            elevation: 5.0,
                            shape: rrBorder(20.0),
                            child: Container(
                              height: 250.0,
                              width: inf,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [primary, primary.withAlpha(100)]),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VaaruText(
                                      'Inventory',
                                      size: 30.0,
                                    ),
                                    Icon(Icons.inventory_rounded, size: 100.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(h: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => navigate(
                            context,
                            route: InquiryScreen.page,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Card(
                            elevation: 5.0,
                            shape: rrBorder(20.0),
                            child: Container(
                              height: 250.0,
                              width: inf,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [blue, blue.withAlpha(100)]),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VaaruText(
                                      'Inquiry',
                                      size: 30.0,
                                    ),
                                    Icon(Icons.auto_graph_rounded, size: 100.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(v: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => navigate(context, route: DeductionsScreen.page),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Card(
                            elevation: 5.0,
                            shape: rrBorder(20.0),
                            child: Container(
                              height: 250.0,
                              width: inf,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [error, error.withAlpha(100)]),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VaaruText(
                                      'Deductions',
                                      size: 30.0,
                                    ),
                                    Icon(Icons.receipt_rounded, size: 100.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(h: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: null,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Card(
                            elevation: 5.0,
                            shape: rrBorder(20.0),
                            child: Container(
                              height: 250.0,
                              width: inf,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [warn, warn.withAlpha(100)]),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VaaruText(
                                      'Returns (COMING SOON)',
                                      size: 30.0,
                                    ),
                                    Icon(Icons.refresh_rounded, size: 100.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
