import 'package:flutter/foundation.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';

class GroceryList extends ChangeNotifier {
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
  Future addProductList(
      {required List<Product> products,required String type}) async {
    if (type == "Fridge") {
      productsFridge.addAll(products);

      notifyListeners();

      return productsFridge;
    }
    if (type == "Other") {
      productsOther.addAll(products);
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.addAll(products);
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }
  Future addProduct(
      {required product_Name,
        required Categorie,
        ingredients,
        required type}) async {
    if (type == "Fridge") {
      productsFridge.add(new Product(
          ingredients:ingredients, product_Name: product_Name, Categorie: Categorie ));
      notifyListeners();
      return productsFridge;
    }
    if (type == "Other") {
      productsOther.add(new Product(
          ingredients:ingredients, product_Name: product_Name, Categorie: Categorie));
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.add(new Product(
         ingredients:ingredients, product_Name: product_Name, Categorie: Categorie ));
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }
  Future deleteProduct(
      {required product_Name,required type}) async {
    if (type == "Fridge") {
      productsFridge.removeWhere((item) => item.product_Name == product_Name);
      notifyListeners();
      return productsFridge;
    }
    if (type == "Other") {
      productsOther.removeWhere((item) => item.product_Name == product_Name);
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.removeWhere((item) => item.product_Name == product_Name);
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }
  Future updateProduct(
      {required product_Name,
        double? quantity,
        Unit? unit,
        required String type}) async {
    if (type == "Fridge") {
      Product findProduct =
      productsFridge.firstWhere((element) => element.product_Name == product_Name);
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
      productsPantry.firstWhere((element) => element.product_Name == product_Name);
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
      productsOther.firstWhere((element) => element.product_Name == product_Name);
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
