import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';

class ProductServices {
  static Future<Product> addProduct({
    required String name,
    required double buyingPrice,
    required double sellingPrice,
  }) async {
    final productBox = await openHiveBox<Product>(Boxes.products);
    final product = Product(
      id: uuid(),
      name: name,
      buyingPrice: buyingPrice,
      sellingPrice: sellingPrice,
    );
    await productBox.add(product);
    productBox.close();
    return product;
  }

  static Future<Product> editProduct({
    required dynamic key,
    required String id,
    required String name,
    required double buyingPrice,
    required double sellingPrice,
  }) async {
    final productBox = await openHiveBox<Product>(Boxes.products);
    final editedProduct = Product(
      id: id,
      name: name,
      buyingPrice: buyingPrice,
      sellingPrice: sellingPrice,
    );
    await productBox.put(key, editedProduct);
    productBox.close();
    return editedProduct;
  }

  static Future<List<Product>> getProducts() async {
    final productBox = await openHiveBox<Product>(Boxes.products);
    final products = productBox.values.toList();
    productBox.close();
    return products;
  }

  static Future<void> removeProduct(key) async {
    final productBox = await openHiveBox<Product>(Boxes.products);
    productBox.delete(key);
  }
}
