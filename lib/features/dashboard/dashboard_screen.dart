import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inventory/inventory_screen.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/widgets/gap.dart';

class DashboardScreen extends StatelessWidget {
  static const page = Routes.dashboard;
  const DashboardScreen({super.key});

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
