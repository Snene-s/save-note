import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/views/home.dart';
import 'package:savenote/views/inventory_setup/other_setup.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:savenote/widgets/modal_product_description.dart';

class ListInventory extends StatelessWidget {
  final String type;
  const ListInventory({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductList>(context, listen: false).getProducts(type);
    return Consumer<ProductList>(
      builder: (context, productsModel, child) {
        var products = [];
        if (type == "Fridge") {
          products = productsModel.productsFridge;
        }
        if (type == "Pantry") {
          products = productsModel.productsPantry;
        }
        if (type == "Other") {
          products = productsModel.productsOther;
        }
        if (products.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  child: SvgPicture.asset(
                      (() {
                        if (type == "Fridge")
                          return "assets/images/fridge_setup_img.svg";
                        if (type == "Pantry")
                          return "assets/images/pantry_setup_img.svg";
                        if (type == "Other")
                          return "assets/images/other_setup_img.svg";
                        return "";
                      }()),
                      height: MediaQuery.of(context).size.height >
                              MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 3.4
                          : MediaQuery.of(context).size.width / 3.4),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text(
                  (() {
                    if (type == "Fridge") return "Setup your fridge";
                    if (type == "Pantry") return "Setup your pantry";
                    return "";
                  }()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text(
                    (() {
                      if (type == "Fridge")
                        return "For refrigerated items such as dairy, meat,\nvegetables, fruits, etc";
                      if (type == "Pantry")
                        return "For dry food items such as rice,\noil,flour, etc.";
                      return "";
                    }()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        height: 2.131,
                        color: Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    (() {
                      if (type == "Fridge") return "Finish fridge setup";
                      if (type == "Pantry") return "Finish pantry setup";
                      if (type == "Other") return "Finish pantry setup";
                      return "";
                    }()),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
              ],
            ),
          );
        }
        return Column(children: [
          Container(
              height: MediaQuery.of(context).size.height - 280,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  child: Text(
                                    "Product",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  child: Text(
                                    "Category",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(3.0, 3.0, 75.0, 3.0),
                                  child: Text(
                                    "Quantity",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]));
                  }
                  return InkWell(
                    onTap: () {
                      modalProductDescription(
                          context,
                          products[index - 1].product_Name,
                          products[index - 1].Categorie,
                          products[index - 1].quantity.toString(),
                          products[index - 1].ingredients!.join(","));
                    },
                    child: SwipeActionCell(
                      backgroundColor: (index % 2 == 1)
                          ? Color.fromRGBO(229, 235, 224, 1)
                          : Colors.transparent,
                      key: ObjectKey(products[index - 1].product_Name),
                      performsFirstActionWithFullSwipe: true,
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              await Provider.of<ProductList>(context,
                                      listen: false)
                                  .deleteProduct(
                                      type: type,
                                      product_Name:
                                          products[index - 1].product_Name);
                            },
                            color: Color.fromRGBO(254, 84, 67, 1)),
                      ],
                      child: Container(
                        height: 60,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Container(
                                        margin: EdgeInsets.all(3.0),
                                        child: Text(products[index - 1]
                                                    .product_Name
                                                    .length >
                                                15
                                            ? products[index - 1]
                                                    .product_Name
                                                    .substring(0, 15) +
                                                "..."
                                            : products[index - 1]
                                                .product_Name))),
                                Flexible(
                                    child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.only(left: 6),
                                  child: Text(
                                    products[index - 1]
                                                .Categorie
                                                .split(",")[0]
                                                .length >
                                            15
                                        ? products[index - 1]
                                                .Categorie
                                                .split(",")[0]
                                                .substring(0, 15) +
                                            "..."
                                        : products[index - 1]
                                            .Categorie
                                            .split(",")[0],
                                  ),
                                )),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.all(1.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 55,
                                                height: 40,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  initialValue:
                                                      products[index - 1]
                                                          .quantity
                                                          .toString(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    if (val.isNotEmpty) {
                                                      Provider.of<ProductList>(
                                                              context,
                                                              listen: false)
                                                          .updateProduct(
                                                              product_Name: products[
                                                                      index - 1]
                                                                  .product_Name,
                                                              quantity:
                                                                  double.parse(
                                                                      val),
                                                              type: type);
                                                    }
                                                  },
                                                  style: TextStyle(
                                                      fontSize: 13, height: 1),
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                                width: 55,
                                                height: 40,
                                                child: DropdownButtonFormField<
                                                    Unit>(
                                                  value:
                                                      products[index - 1].unit,
                                                  onChanged: (val) {
                                                    Provider.of<ProductList>(
                                                            context,
                                                            listen: false)
                                                        .updateProduct(
                                                            product_Name:
                                                                products[index -
                                                                        1]
                                                                    .product_Name,
                                                            unit: val,
                                                            type: type);
                                                  },
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            4, 0, 2, 0),
                                                  ),
                                                  items: <Unit>[
                                                    Unit.pcs,
                                                    Unit.gal,
                                                    Unit.kg,
                                                    Unit.oz
                                                  ].map<DropdownMenuItem<Unit>>(
                                                      (Unit value) {
                                                    if (value == Unit.pcs)
                                                      return DropdownMenuItem<
                                                          Unit>(
                                                        value: value,
                                                        child: Text(
                                                          "pcs",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                      );
                                                    if (value == Unit.gal)
                                                      return DropdownMenuItem<
                                                          Unit>(
                                                        value: value,
                                                        child: Text(
                                                          "gal",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                      );
                                                    if (value == Unit.kg)
                                                      return DropdownMenuItem<
                                                          Unit>(
                                                        value: value,
                                                        child: Text("kg",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                      );
                                                    if (value == Unit.oz)
                                                      return DropdownMenuItem<
                                                          Unit>(
                                                        value: value,
                                                        child: Text("oz",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                      );
                                                    return DropdownMenuItem<
                                                        Unit>(
                                                      value: value,
                                                      child: Text("kg",
                                                          style: TextStyle(
                                                              fontSize: 14)),
                                                    );
                                                  }).toList(),
                                                ))
                                          ]),
                                    ))
                              ]),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: products.length + 1,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Ink(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () async {
                  if (type == "Fridge") {
                    var response =
                        await Provider.of<ProductList>(context, listen: false)
                            .submitProductsSetup(type: type);
                    if (response["status"])
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherSetup()));
                  }

                  if (type == "Pantry") {
                    var response =
                        await Provider.of<ProductList>(context, listen: false)
                            .submitProductsSetup(type: type);
                    if (response["status"])
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Container(
                  child: Center(
                    child: Text(
                      (() {
                        if (type == "Fridge") return "Finish fridge setup";
                        if (type == "Pantry") return "Finish pantry setup";
                        return "";
                      }()),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
