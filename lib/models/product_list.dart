import 'package:flutter/foundation.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';

class ProductList extends ChangeNotifier {
  List<Product> productsFridge = [];
  List<Product> productsPantry = [];
  List<Product> productsOther = [];
  bool _isLoading = false;
  bool get loading => _isLoading;

  getProducts(String type) async {
    if (type == "Fridge") {
      return productsFridge;
    }
    if (type == "Other") {
      return productsOther;
    }
    if (type == "Pantry") {
      return productsPantry;
    }
    return [];
  }

  Future addProduct(
      {required fdcId,
      required description,
      required foodCategory,
        ingredients,
      required type}) async {
    if (type == "Fridge") {
      productsFridge.add(new Product(
          fdcId: fdcId, description: description, foodCategory: foodCategory,ingredients:ingredients ));
      notifyListeners();
      return productsFridge;
    }
    if (type == "Other") {
      productsOther.add(new Product(
          fdcId: fdcId, description: description, foodCategory: foodCategory,ingredients:ingredients ));
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.add(new Product(
          fdcId: fdcId, description: description, foodCategory: foodCategory,ingredients:ingredients ));
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }
  Future deleteProduct(
      {required fdcId,required type}) async {
    if (type == "Fridge") {
      productsFridge.removeWhere((item) => item.fdcId == fdcId);
      notifyListeners();
      return productsFridge;
    }
    if (type == "Other") {
      productsOther.removeWhere((item) => item.fdcId == fdcId);
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.removeWhere((item) => item.fdcId == fdcId);
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }
  Future updateProduct(
      {required fdcId,
      double? quantity,
      Unit? unit,
      required String type}) async {
    if (type == "Fridge") {
      Product findProduct =
          productsFridge.firstWhere((element) => element.fdcId == fdcId);
      if (quantity != null) {
        findProduct.changeQuantity(quantity);
      }
      if (unit != null) {
        findProduct.changeUnit(unit);
      }
      notifyListeners();
      return productsFridge;
    }
    if (type == "Pantry") {
      Product findProduct =
          productsPantry.firstWhere((element) => element.fdcId == fdcId);
      if (quantity != null) {
        findProduct.changeQuantity(quantity);
      }
      if (unit != null) {
        findProduct.changeUnit(unit);
      }
      notifyListeners();
      return productsPantry;
    }
    if (type == "Other") {
      Product findProduct =
      productsOther.firstWhere((element) => element.fdcId == fdcId);
      if (quantity != null) {
        findProduct.changeQuantity(quantity);
      }
      if (unit != null) {
        findProduct.changeUnit(unit);
      }
      notifyListeners();
      return productsOther;
    }
    notifyListeners();
    return [];
  }
}
