import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/services/sale_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';

class SaleProvider extends ChangeNotifier {
  final _saleItems = <SaleProduct>[];
  var _total = 0.0;

  List<SaleProduct> get saleItems => _saleItems;
  double get total => _total;

  void addSaleItem(Product product) {
    final existingIndex = _saleItems.indexWhere((element) => element.product.id == product.id);
    if (existingIndex != -1) {
      final existingProduct = _saleItems.removeAt(existingIndex);
      _saleItems.insert(existingIndex, existingProduct.setQuantity(existingProduct.quantity + 1));
    } else {
      _saleItems.add(SaleProduct(product: product, quantity: 1));
    }
    _total = _saleItems.fold(0.0, (sum, item) => sum + item.product.sellingPrice * item.quantity);
    notifyListeners();
  }

  void clearCart(BuildContext context) => confirm(
        context,
        confirmMessage: 'Do you want to clear the cart?',
        confirmLabel: 'CLEAR',
        confirmColor: error,
        dismissColor: blue,
        onConfirm: () {
          _saleItems.clear();
          _total = 0.0;
          notifyListeners();
        },
      );

  void makeSale(
    BuildContext context, {
    required double? discount,
  }) =>
      waiting(
        context,
        waitingMessage: 'Adding...',
        process: () => SaleServices.makeSale(
          saleProducts: _saleItems,
          discount: discount,
        ),
        afterProcessed: (sale) {
          _saleItems.clear();
          _total = 0.0;
          notify(title: 'Sold', body: 'A new sale has been made successfully.');
          notifyListeners();
        },
      );

  void removeSaleItem(String productId) {
    final existingIndex = _saleItems.indexWhere((element) => element.product.id == productId);
    final existingProduct = _saleItems.removeAt(existingIndex);
    final newQuantity = existingProduct.quantity - 1;
    if (newQuantity > 0) _saleItems.insert(existingIndex, existingProduct.setQuantity(newQuantity));
    _total = _saleItems.isNotEmpty ? _saleItems.fold(0.0, (sum, item) => sum + item.product.sellingPrice * item.quantity) : 0.0;
    notifyListeners();
  }
}
