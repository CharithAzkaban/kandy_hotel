import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/services/product_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/enums.dart';

class ProductProvider extends ChangeNotifier {
  final _products = <Product>[];
  final _filteredProducts = <Product>[];

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;

  void addProduct(
    BuildContext context, {
    required String name,
    required double buyingPrice,
    required double sellingPrice,
    required TextEditingController searchController,
  }) =>
      waiting(
        context,
        waitingMessage: 'Adding...',
        process: () => ProductServices.addProduct(
          name: name,
          buyingPrice: buyingPrice,
          sellingPrice: sellingPrice,
        ),
        afterProcessed: (product) {
          _products.add(product);
          if (product.name.toLowerCase().contains(searchController.text.toLowerCase())) {
            _filteredProducts.add(product);
          }
          notify(title: 'Added', body: 'A new product has been added successfully.');
          notifyListeners();
        },
      );

  void filterProducts(String keyword) => debounce(
        Debounces.FILTER,
        onExecute: () {
          _filteredProducts.clear();
          if (keyword.isEmpty) {
            _filteredProducts.addAll(_products);
          } else {
            _filteredProducts.addAll(_products.where((element) => element.name.toLowerCase().contains(keyword.toLowerCase())));
          }
          notifyListeners();
        },
      );

  void loadProducts(BuildContext context) => waiting(
        context,
        waitingMessage: 'Loading products...',
        process: () => ProductServices.getProducts(),
        afterProcessed: (products) {
          _products.clear();
          _products.addAll(products);
          _filteredProducts.addAll(products);
        },
      );

  void removeProduct(
    BuildContext context, {
    required Product product,
  }) =>
      confirm(
        context,
        confirmMessage: 'Would you like to remove "${product.name}"?',
        onConfirm: () => waiting(
          context,
          process: () => ProductServices.removeProduct(product.key),
          afterProcessed: (_) {
            final productId = product.id;
            _products.removeWhere((element) => element.id == productId);
            _filteredProducts.removeWhere((element) => element.id == productId);
            notify(title: 'Removed', body: 'A product has been removed.');
            notifyListeners();
          },
        ),
      );
}
