import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/grocery_list.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/widgets/modal_product_description.dart';

class ListGrocery extends StatefulWidget {
  final String type;
  const ListGrocery({Key? key, required this.type})
      : super(key: key);

  @override
  _ListGroceryState createState() =>
      _ListGroceryState();
}

class _ListGroceryState
    extends State<ListGrocery> {
  int _index = 0;
  late Product undoThrownProduct;
  bool lastItem = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    // COMING SOON Fix problem Undo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (lastItem == true) {

      Provider.of<GroceryList>(context, listen: false).addProduct(
          product_Name: undoThrownProduct.product_Name,
          Categorie: undoThrownProduct.Categorie,
          ingredients: undoThrownProduct.ingredients,
          type: widget.type);
      setState(() {lastItem=false;
      });
    }
    return Consumer<GroceryList>(
      builder: (context, productsModel, child) {
        var products = [];
        if (widget.type == "Fridge") {
          products = productsModel.productsFridge;
        }
        if (widget.type == "Pantry") {
          products = productsModel.productsPantry;
        }
        if (widget.type == "Other") {
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
                        if (widget.type == "Fridge")
                          return "assets/images/fridge_setup_img.svg";
                        if (widget.type == "Pantry")
                          return "assets/images/pantry_setup_img.svg";
                        if (widget.type == "Other")
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
                    if (widget.type == "Fridge") return "Setup your fridge";
                    if (widget.type == "Pantry") return "Setup your pantry";
                    if (widget.type == "Other") return "Setup your Freezer";
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
                      if (widget.type == "Fridge")
                        return "For refrigerated items such as dairy, meat,\nvegetables, fruits, etc";
                      if (widget.type == "Pantry")
                        return "For dry food items such as rice,\noil,flour, etc.";
                      if (widget.type == "Other")
                        return "For refrigerated items such as meat,\nvegetables, fruits, etc.";
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
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(children: [
            Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                          height: 60,
                          padding:
                          const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.all(3.0),
                                    width: (MediaQuery.of(context).size.width -
                                        40) /
                                        3,
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
                                    width: (MediaQuery.of(context).size.width -
                                        40) /
                                        3,
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
                                  flex: 1,
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                        40) /
                                        3,
                                    margin:
                                    EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
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
                    return SwipeActionCell(
                      key: ObjectKey(products[index - 1].description),
                      performsFirstActionWithFullSwipe: true,
                      backgroundColor: (index % 2 == 1)
                          ? Color.fromRGBO(229, 235, 224, 1)
                          : Colors.transparent,
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onTap: (CompletionHandler handler) async {
                              await handler(true);
                              lastItem = false;
                              undoThrownProduct = products[index - 1];

                              await Provider.of<GroceryList>(context,
                                  listen: false)
                                  .deleteProduct(
                                  type: widget.type,
                                  product_Name: products[index - 1].product_Name);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(

                                    content: const Text('1 item deleted'),
                                    duration: const Duration(seconds: 3),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: ()async {
                                        if (index==1){
                                          lastItem = true;
                                        }else{
                                          await Provider.of<GroceryList>(context, listen: false).addProduct(
                                              product_Name: undoThrownProduct.product_Name,
                                              Categorie: undoThrownProduct.Categorie,
                                              ingredients: undoThrownProduct.ingredients,
                                              type: widget.type);}
                                        setState(() {
                                        });
                                      },
                                    ),
                                  ));


                            },
                            color: Color.fromRGBO(254, 84, 67, 1)),
                      ],
                      child: Container(
                        height: 52,
                        padding:
                        const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  modalProductDescription(
                                      context,
                                      products[index - 1].description,
                                      products[index - 1].foodCategory,
                                      products[index - 1].quantity.toString(),
                                      products[index - 1].ingredients.join(","));
                                },
                                child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                        40) /
                                        3 +
                                        10,
                                    margin: EdgeInsets.all(3.0),
                                    child:

                                      Text(products[index - 1]
                                          .description
                                          .length >
                                          8
                                          ? products[index - 1]
                                          .description
                                          .substring(0, 8) +
                                          "..."
                                          : products[index - 1].description),
                                    ),
                              ),
                              Container(
                                width:
                                (MediaQuery.of(context).size.width - 40) /
                                    3,
                                margin: EdgeInsets.all(3.0),
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  products[index - 1]
                                      .foodCategory
                                      .split(",")[0] .length >
                                      10
                                      ? products[index - 1]
                                      .foodCategory
                                      .split(",")[0]
                                      .substring(0, 10) +
                                      "..." : products[index - 1]
                                      .foodCategory
                                      .split(",")[0],
                                ),
                              ),
                              Container(
                                width:
                                (MediaQuery.of(context).size.width - 40) /
                                    3 -
                                    10,
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                       SizedBox(
                                          child: Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: Text(
                                                products[index - 1]
                                                    .quantity
                                                    .toString()),
                                          )),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Product.unitToString(
                                                  products[index - 1].unit),
                                            ),
                                          ))
                                    ]),
                              )
                            ]),
                      ),
                    );
                  },
                  itemCount: products.length + 1,
                )),
          ]),
        );
      },
    );
  }
}
