import 'package:flutter/material.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_icon_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class InventoryScreen extends StatefulWidget {
  static const page = Routes.inventory;
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late final ProductProvider _productProvider;

  @override
  void initState() {
    super.initState();
    _productProvider = provider<ProductProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const VaaruText('Inventory'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: VaaruIconButton(
              icon: Icons.add_rounded,
              color: white,
              onPressed: () => _productProvider.addProduct(context),
            ),
          ),
        ],
      ),
      body: const CustomScrollView(
        slivers: [],
      ),
    );
  }
}
