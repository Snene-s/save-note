import 'package:savenote/enum/enum_app.dart';

class Product {
  final String description;
  final int fdcId;
  final String foodCategory;
   List? ingredients;
   double quantity;
   Unit unit;

   Product(
      {required this.description,
        required this.fdcId,
        required this.foodCategory,
         this.ingredients,
        this.quantity=1,this.unit=Unit.pcs});
  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(fdcId: json["fdcId"], foodCategory: json["foodCategory"], description: json["description"],ingredients: json["foodNutrients"]);

  changeQuantity(double quant){
    this.quantity=quant;
  }
  changeUnit(Unit x){
    this.unit=x;
  }
  Map<String, dynamic> toJson() =>
      {"fdcId": fdcId, "description": description, "foodCategory": foodCategory,"quantity":quantity};
}

