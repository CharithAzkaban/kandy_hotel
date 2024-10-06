import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inquiry/inquiry_screen.dart';
import 'package:kandy_hotel/features/inventory/inventory_screen.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';

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
  Widget build(BuildContext context) => Padding(
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
                          borderRadius: BorderRadius.circular(20.0),
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
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(h: 10.0),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20.0),
                    child: Card(
                      elevation: 5.0,
                      shape: rrBorder(20.0),
                      child: Container(
                        height: 250.0,
                        width: inf,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
