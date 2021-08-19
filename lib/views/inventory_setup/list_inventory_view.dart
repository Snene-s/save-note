import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/views/inventory_setup/pantry_setup.dart';

class ListInventory extends StatelessWidget {
  const ListInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductList>(context, listen: false).getProducts();
    return Consumer<ProductList>(
      builder: (context, productsModel, child) {
        if (productsModel.products.length == 0) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/fridge_setup_img.png',
                    width: 231.26,
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                Text("Start now! ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        height: 2.131,
                        color: Color.fromRGBO(102, 102, 102, 1))),
                SizedBox(
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                  decoration: BoxDecoration(
                    color: AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Setup fridge",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
        return Column(children: [
          Container(
              height: MediaQuery.of(context).size.height - 250,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Product",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Category",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Quantity",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                                  margin: EdgeInsets.all(1.0),
                                  child: Text(productsModel
                                      .products[index - 1].description))),
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.all(1.0),
                            child: Text(
                              productsModel.products[index - 1].foodCategory,
                            ),
                          )),
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.all(1.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(productsModel
                                      .products[index - 1].quantity
                                      .toString()),
                                  Text("pcs")
                                ]),
                          ))
                        ]),
                  );
                },
                itemCount: productsModel.products.length + 1,
              )),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PantrySetup()));
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Setup fridge",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
