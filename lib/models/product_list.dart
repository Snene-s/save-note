import 'package:flutter/foundation.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';

class ProductList extends ChangeNotifier {
  List <Product>products =[];
  bool _isLoading = false;
  bool get loading => _isLoading;

  getProducts() async{
    return products;
  }
  Future addProduct({required fdcId, required description, required foodCategory}) async{

    products.add(new Product(fdcId: fdcId,description:description,foodCategory: foodCategory ));

    notifyListeners();
    return products;

  }

  Future updateProduct({required fdcId,double? quantity,Unit? unit}) async{

    Product findProduct= products.firstWhere((element) =>
    element.fdcId == fdcId);
    if(quantity!=null){
    findProduct.changeQuantity(quantity);}
    if(unit!=null){
      findProduct.changeUnit(unit);}
    notifyListeners();
    return products;

  }

}
