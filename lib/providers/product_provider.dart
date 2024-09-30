import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/services/product_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
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

  void editProduct(
    BuildContext context, {
    required dynamic key,
    required String id,
    required String name,
    required double buyingPrice,
    required double sellingPrice,
  }) =>
      waiting(
        context,
        waitingMessage: 'Modifying...',
        process: () => ProductServices.editProduct(
          key: key,
          id: id,
          name: name,
          buyingPrice: buyingPrice,
          sellingPrice: sellingPrice,
        ),
        afterProcessed: (product) {
          final index = _products.indexWhere((element) => element.id == product.id);
          if (index != -1) {
            _products.removeAt(index);
            _products.insert(index, product);
          }
          final filterIndex = _filteredProducts.indexWhere((element) => element.id == product.id);
          if (filterIndex != -1) {
            _filteredProducts.removeAt(filterIndex);
            _filteredProducts.insert(filterIndex, product);
          }
          notify(title: 'Modified', body: 'A new product has been modified successfully.');
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
        confirmColor: error,
        dismissColor: blue,
        confirmLabel: 'REMOVE',
        dismissLabel: 'KEEP',
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
