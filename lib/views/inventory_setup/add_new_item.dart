import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/widgets/widget.dart';

class AddNewItem extends StatefulWidget {
  final String type;
  const AddNewItem({Key? key, required this.type}) : super(key: key);

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String productName = "", itemIngredient = "";
  Unit unit = Unit.kg;
  String category = "";
  List<String> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Add new item",
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Product name",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      productName = val;
                      setState(() {});
                    },
                    keyboardType: TextInputType.name,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "Enter product name...")),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Category",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      category = val;
                      setState(() {});
                    },
                    keyboardType: TextInputType.name,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "select category...")),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Unit",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<Unit>(
                  iconSize: 24,
                  elevation: 16,
                  decoration: CommonStyle.textFieldStyle(
                      hintTextStr: "Select a unit"),
                  onChanged: (val) {
                    unit = val!;
                    setState(() {});
                  },
                  items: <Unit>[Unit.pcs, Unit.gal, Unit.kg, Unit.oz]
                      .map<DropdownMenuItem<Unit>>((Unit value) {
                    if (value == Unit.pcs)
                      return DropdownMenuItem<Unit>(
                        value: value,
                        child: Text(
                          "pcs",
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    if (value == Unit.gal)
                      return DropdownMenuItem<Unit>(
                        value: value,
                        child: Text(
                          "gal",
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    if (value == Unit.kg)
                      return DropdownMenuItem<Unit>(
                        value: value,
                        child: Text("kg", style: TextStyle(fontSize: 14)),
                      );
                    if (value == Unit.oz)
                      return DropdownMenuItem<Unit>(
                        value: value,
                        child: Text("oz", style: TextStyle(fontSize: 14)),
                      );
                    return DropdownMenuItem<Unit>(
                      value: value,
                      child: Text("kg", style: TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Ingredients",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                        controller: _controller,
                        onChanged: (val) {
                          itemIngredient = val;
                          setState(() {});
                        },
                        keyboardType: TextInputType.name,
                        decoration: CommonStyle.textFieldStyle(
                            hintTextStr: "For example carrot...")),
                  ),
                  Flexible(
                      child: InkWell(
                          onTap: () {
                            ingredients.add(itemIngredient);
                            itemIngredient = "";
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                            _controller.clear();
                          },
                          child: Container(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 13),
                            decoration: BoxDecoration(
                                color: itemIngredient.isNotEmpty
                                    ? AppColors.PRIMARY_COLOR
                                    : AppColors.SECONDARY_COLOR,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                          )))
                ]),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 70,
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          padding: new EdgeInsets.all(5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(),
                                Text(
                                  ingredients[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed: () {
                                      ingredients.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      size: 16,
                                      color: Colors.white,
                                    ))
                              ]),
                          decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(18.0)),
                        );
                      },
                      itemCount: ingredients.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 30,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 6.0,
                          maxCrossAxisExtent: 110),
                    )),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Random random = new Random();
                    Provider.of<ProductList>(
                      context,
                      listen: false)
                      .addProduct(
                      fdcId:random.nextInt(10000),
                      description:productName,
                      foodCategory:category,
                      ingredients: ingredients,
                      type: widget.type);
                    Navigator.pop(context);
                    },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                    decoration: BoxDecoration(
                      color: productName.isNotEmpty
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
