import 'package:flutter/foundation.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';
import 'package:collection/collection.dart';

class ShoppingList extends ChangeNotifier {
  List<Product> choppingList = [];

  bool _isLoading = false;
  bool get loading => _isLoading;

  getProducts(String type) async {
    return choppingList;
  }

  Future addProductList({required List<Product> products}) async {
    for (final product in products) {
      //
      if (choppingList
              .firstWhereOrNull((element) => element.product_Name == product.product_Name) ==
          null) choppingList.add(product);
    }

    notifyListeners();

    return choppingList;
  }

  Future addProduct({
    required product_Name,
    required Categorie,
    ingredients,
  }) async {
    choppingList.add(new Product(
         ingredients:ingredients, product_Name: product_Name, Categorie: Categorie));
    notifyListeners();
    return choppingList;
  }

  Future deleteProduct({required product_Name}) async {
    choppingList.removeWhere((item) => item.product_Name == product_Name);
    notifyListeners();
    return choppingList;
  }

  Future updateProduct({
    required product_Name,
    double? quantity,
    Unit? unit,
  }) async {
    Product findProduct =
        choppingList.firstWhere((element) => element.product_Name == product_Name);
    if (quantity != null) {
      findProduct.changeQuantity(quantity);
    }
    if (unit != null) {
      findProduct.changeUnit(unit);
    }
    notifyListeners();
    return choppingList;
  }

  Future checkProduct({required product_Name, bool? val}) async {
    Product findProduct =
        choppingList.firstWhere((element) => element.product_Name == product_Name);

    findProduct.checked(val);

    notifyListeners();
    return choppingList;
  }
}
