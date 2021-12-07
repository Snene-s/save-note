import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/widgets/modal_product_description.dart';

class AddItemsList extends StatelessWidget {
  final List<Product> products;
  final Function deleteHandler;
  final Function quantityHandler;
  final Function unitHandler;
  final Function submitHandler;
  const AddItemsList(
      {Key? key,
      required this.products,
      required this.deleteHandler,
      required this.quantityHandler,
      required this.unitHandler,
      required this.submitHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.length == 0) return Container();
    return Column(children: [
      Container(
          height: MediaQuery.of(context).size.height - 240,
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    height: 80,
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
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
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(3.0, 3.0, 75.0, 3.0),
                              child: Text(
                                "Quantity",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                          deleteHandler(index - 1);
                        },
                        color: Color.fromRGBO(254, 84, 67, 1)),
                  ],
                  child: Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Container(
                                    margin: EdgeInsets.all(3.0),
                                  child:  Text(products[index - 1]
                                      .product_Name
                                      .length >
                                      10
                                      ? products[index - 1]
                                      .product_Name
                                      .substring(0, 10).split(" ")[0] +
                                      "..."
                                      : products[index - 1].product_Name),
                                  )),
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
                                              initialValue: products[index - 1]
                                                  .quantity
                                                  .toString(),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (val) {
                                                quantityHandler(index - 1, val);
                                              },
                                              style: TextStyle(
                                                  fontSize: 13, height: 1),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                            width: 55,
                                            height: 40,
                                            child:
                                                DropdownButtonFormField<Unit>(
                                              value: products[index - 1].unit,
                                              onChanged: (val) {
                                                unitHandler(index - 1, val);
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
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
                                                  return DropdownMenuItem<Unit>(
                                                    value: value,
                                                    child: Text(
                                                      "pcs",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  );
                                                if (value == Unit.gal)
                                                  return DropdownMenuItem<Unit>(
                                                    value: value,
                                                    child: Text(
                                                      "gal",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  );
                                                if (value == Unit.kg)
                                                  return DropdownMenuItem<Unit>(
                                                    value: value,
                                                    child: Text("kg",
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                  );
                                                if (value == Unit.oz)
                                                  return DropdownMenuItem<Unit>(
                                                    value: value,
                                                    child: Text("oz",
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                  );
                                                return DropdownMenuItem<Unit>(
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
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: (products.length == 0)
                ? AppColors.SECONDARY_COLOR
                : AppColors.PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              submitHandler();
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                "Add items",
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
    ]);
  }
}
