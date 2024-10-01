import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_form.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_item.dart';
import 'package:kandy_hotel/features/inventory/widgets/sale_item.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/providers/sale_provider.dart';
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
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();

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
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: CustomScrollView(
                    controller: _scrollController1,
                    slivers: [
                      SliverAppBar(
                        shape: rrBorder(15.0),
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
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          controller: _scrollController2,
                          slivers: [
                            Consumer<SaleProvider>(
                              builder: (context, saleData, _) {
                                final saleItems = saleData.saleItems;
                                return saleItems.isNotEmpty
                                    ? SliverList.separated(
                                        itemBuilder: (context, index) => SaleItem(saleItems[index]),
                                        separatorBuilder: (context, index) => const Divider(),
                                        itemCount: saleItems.length,
                                      )
                                    : SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: dHeight(context) * 0.8,
                                          child: const Center(
                                            child: VaaruText('Cart is empty.'),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 5.0),
                      const Divider(height: 5.0),
                      Consumer<SaleProvider>(builder: (context, saleData, _) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const VaaruText(
                                'Total',
                                size: 20.0,
                              ),
                              VaaruText(
                                price(saleData.total),
                                size: 20.0,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
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
