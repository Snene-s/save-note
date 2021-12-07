import 'package:flutter/foundation.dart';
import 'package:savenote/Services/inventory_service.dart';
import 'package:savenote/Services/product_search_api.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';

class ProductList extends ChangeNotifier {
  List<Product> productsFridge = [];
  List<Product> productsPantry = [];
  List<Product> productsOther = [];
  bool _isLoading = false;
  bool get loading => _isLoading;
  final ProductSearchRep productService = ProductSearchRep();
  final InventoryService inventoryService = InventoryService();
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
      {required List<Product> products, required String type}) async {
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
          ingredients: ingredients,
          product_Name: product_Name,
          Categorie: Categorie));
      notifyListeners();
      return productsFridge;
    }
    if (type == "Other") {
      productsOther.add(new Product(
          ingredients: ingredients,
          product_Name: product_Name,
          Categorie: Categorie));
      notifyListeners();
      return productsOther;
    }
    if (type == "Pantry") {
      productsPantry.add(new Product(
          ingredients: ingredients,
          product_Name: product_Name,
          Categorie: Categorie));
      notifyListeners();
      return productsFridge;
    }

    notifyListeners();
    return [];
  }

  Future deleteProduct({required product_Name, required type}) async {
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
      Product findProduct = productsFridge
          .firstWhere((element) => element.product_Name == product_Name);
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
      Product findProduct = productsPantry
          .firstWhere((element) => element.product_Name == product_Name);
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
      Product findProduct = productsOther
          .firstWhere((element) => element.product_Name == product_Name);
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

  Future submitProductsSetup({required String type}) async {
    if (type == "Fridge") {
      var response = await inventoryService.addProductsToInventory(
          type: "fridge",
          products: productsFridge.map((e) => {
                "name": e.product_Name,
                "category": e.Categorie,
                "unit": e.unit.toString(),
                "quantity": e.quantity.toString(),
                "expiration_time_frame": new DateTime.now().add(const Duration(days: 10))
              }));
      return response;
    }
    if (type == "Pantry") {
      print(productsPantry[0].product_Name);
      print(productsPantry[0].ingredients);
      print(productsPantry[0].Categorie);
      print(productsPantry[0].unit);

      var response = await inventoryService.addProductsToInventory(
          type: "pantry",
          products: productsPantry.map((e) => {
            "name": e.product_Name,
            "category": e.Categorie,
            "unit": e.unit.toString(),
            "quantity": e.quantity.toString(),
            "expiration_time_frame": new DateTime.now().add(const Duration(days: 10))
          }));
      return response;
    }
    if (type == "Other") {
      var response = await inventoryService.addProductsToInventory(
          type: "freeze",
          products: productsOther.map((e) => {
            "name": e.product_Name,
            "category": e.Categorie,
            "unit": e.unit.toString(),
            "quantity": e.quantity.toString(),
            "expiration_time_frame": new DateTime.now().add(const Duration(days: 10))
          }));
      return response;
    }

    return ;
  }

  searchByCode({required String code, required String type}) async {
    this._isLoading = true;

    var response = await productService.searchByCode(code);
    if (response["status"]) {
      if (type == "Fridge") {
        List<dynamic> list = response["data"];
        productsFridge.addAll(list.map((e) => new Product(
            product_Name: e["product_Name"],
            Categorie: e["Categorie"].toString(),
            ingredients: e["ingredients"].toString().split(","))));
      }
      if (type == "Pantry") {
        List<dynamic> list = response["data"];
        productsPantry.addAll(list.map((e) => new Product(
            product_Name: e["product_Name"],
            Categorie: e["Categorie"].toString(),
            ingredients: e["ingredients"].toString().split(","))));
      }
      if (type == "Other") {
        List<dynamic> list = response["data"];
        productsOther.addAll(list.map((e) => new Product(
            product_Name: e["product_Name"],
            Categorie: e["Categorie"].toString(),
            ingredients: e["ingredients"].toString().split(","))));
      }
    }
    this._isLoading = false;
    notifyListeners();
    return response;
  }



  fetchInventory(id) async {
    this._isLoading = true;
    notifyListeners();
    var response = await inventoryService.getInventory(id);
    print(response["data"]);
    if (response["status"]) {
      productsFridge=[];
      productsPantry=[];
      productsOther=[];
        List<dynamic> listFridge = response["data"]["fridge"];
        productsFridge.addAll(listFridge.map((e) => new Product(
            product_Name: e["product_Name"],
            Categorie: e["Categorie"].toString(),
            ingredients: e["ingredients"].toString().split(","))));

      List<dynamic> listPantry = response["data"]["pantry"];
      productsPantry.addAll(listPantry.map((e) => new Product(
          product_Name: e["product_Name"],
          Categorie: e["Categorie"].toString(),
          ingredients: e["ingredients"].toString().split(","))));

      List<dynamic> listOther = response["data"]["freeze"];
      productsOther.addAll(listOther.map((e) => new Product(
          product_Name: e["product_Name"],
          Categorie: e["Categorie"].toString(),
          ingredients: e["ingredients"].toString().split(","))));

    this._isLoading = false;
    notifyListeners();
    return response;
  }
}
}
