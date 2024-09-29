import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_form.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_item.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/dummy.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/popup_action.dart';
import 'package:kandy_hotel/widgets/vaaru_icon_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  static const page = Routes.inventory;
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late final ProductProvider _productProvider;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productProvider = provider<ProductProvider>(context);
    _searchController.addListener(() => _productProvider.filterProducts(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: const VaaruText('Inventory'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: VaaruIconButton(
                icon: Icons.add_rounded,
                color: white,
                onPressed: () => _addProduct(context),
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: const Icon(Icons.search_rounded),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    VaaruTff(
                      controller: _searchController,
                      width: dWidth(context) * 0.3,
                      hintText: 'Search products...',
                      suffixIcon: VaaruIconButton(
                        icon: Icons.close_rounded,
                        color: error,
                        onPressed: () => _searchController.clear(),
                      ),
                    ),
                    const Gap(h: 20.0),
                    Consumer<ProductProvider>(
                      builder: (context, productData, _) {
                        final filteredCount = productData.filteredProducts.length;
                        if (_searchController.text.isNotEmpty) {
                          return VaaruText(
                            '${number(filteredCount, unit: 'product', zeroAsNo: true)} matched',
                            size: 12.0,
                          );
                        }
                        return const Dummy();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, productData, _) {
                final products = productData.filteredProducts;
                return products.isNotEmpty
                    ? SliverList.separated(
                        itemBuilder: (context, index) => ProductItem(products[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: products.length,
                      )
                    : SliverToBoxAdapter(
                        child: SizedBox(
                          height: dHeight(context) * 0.8,
                          child: const Center(
                            child: VaaruText('No products available.'),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      );

  void _addProduct(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final buyingPriceController = TextEditingController();
    final sellingPriceController = TextEditingController();
    final isOk = await popup<bool>(
      context,
      title: 'Add Product',
      cancelLabel: 'DISMISS',
      body: ProductForm(
        formKey: formKey,
        nameController: nameController,
        buyingPriceController: buyingPriceController,
        sellingPriceController: sellingPriceController,
      ),
      actions: [
        PopupAction(
          label: 'ADD',
          validationKey: formKey,
          popResult: true,
        ),
      ],
    );

    if (isOk != null && isOk && context.mounted) {
      _productProvider.addProduct(
        context,
        name: nameController.text.trim(),
        buyingPrice: double.parse(buyingPriceController.text.trim()),
        sellingPrice: double.parse(sellingPriceController.text.trim()),
        searchController: _searchController,
      );
    }
  }
}
