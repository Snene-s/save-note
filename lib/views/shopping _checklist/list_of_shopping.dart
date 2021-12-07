import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/models/shopping_list.dart';
import 'package:savenote/widgets/modal_product_description.dart';

class ListOfShopping extends StatelessWidget {
  const ListOfShopping({Key? key}) : super(key: key);
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.SECONDARY_COLOR;
    }
    return AppColors.PRIMARY_COLOR;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingList>(
      builder: (context, productsModel, child) {
        var products = [];

        products = productsModel.choppingList;

        if (products.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  child: SvgPicture.asset("assets/images/fridge_setup_img.svg",
                      height: MediaQuery.of(context).size.height >
                              MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 3.4
                          : MediaQuery.of(context).size.width / 3.4),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text(
                  "Setup your fridge",
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
                    "For refrigerated items such as dairy, meat,\nvegetables, fruits, etc",
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Container(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SwipeActionCell(
                      key: ObjectKey(products[index].description),
                      performsFirstActionWithFullSwipe: true,
                      backgroundColor: (index % 2 == 0)
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

                              await Provider.of<ShoppingList>(context,
                                      listen: false)
                                  .deleteProduct(product_Name: products[index].product_Name);
                            },
                            color: Color.fromRGBO(254, 84, 67, 1)),
                      ],
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                (MediaQuery.of(context).size.width ) /
                                    3 +30,
                                child: Row(children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    fillColor: MaterialStateProperty.resolveWith(
                                        getColor),
                                    value: products[index].isChecked,
                                    onChanged: (val) {
                                      Provider.of<ShoppingList>(context,
                                              listen: false)
                                          .checkProduct(
                                              product_Name: products[index].product_Name,
                                              val: val);
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      modalProductDescription(
                                          context,
                                          products[index].description,
                                          products[index].foodCategory,
                                          products[index].quantity.toString(),
                                          products[index].ingredients.join(","));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(3.0),
                                      child: Text(
                                          products[index].description.length > 10
                                              ? products[index]
                                                      .description
                                                      .substring(0, 10) +
                                                  "..."
                                              : products[index].description),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                        3,
                                margin: EdgeInsets.all(3.0),
                                child: Text(
                                  products[index].foodCategory.split(",")[0],
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                        3,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(products[index]
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
                                              products[index].unit),
                                        ),
                                      ))
                                    ]),
                              )
                            ]),
                      ),
                    );
                  },
                  itemCount: products.length,
                )),
          ]),
        );
      },
    );
  }
}
