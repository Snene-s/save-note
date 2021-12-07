import 'package:savenote/enum/enum_app.dart';

class Product {

  final String product_Name;
  final String Categorie;

  List? ingredients;
  int? gtinUpc;
  int shelf_life=10;
  double quantity;
  Unit unit;
  bool isChecked;

  Product(
      {
      required this.product_Name,
      required this.Categorie,
      this.ingredients,
      this.quantity = 1,
      this.unit = Unit.pcs,this.isChecked=false});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      product_Name: json["product_Name"],
      Categorie: json["Categorie"],
      ingredients: json["ingredients"]);

  changeQuantity(double quant) {
    this.quantity = quant;
  }

  changeUnit(Unit x) {
    this.unit = x;
  }
  checked(val) {
    this.isChecked = val;
  }

 static String unitToString(Unit unit) {
    switch (unit) {
      case Unit.kg:
        {
          return "kg";
        }

      case Unit.oz:
        {
          return "oz";
        }
      case Unit.pcs:
        {
          return "pcs";
        }
      case Unit.gal:
        {
          return "gal";
        }

      default:
        {
          return "";
        }
    }
  }


}
