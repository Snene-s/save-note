import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/Services/product_search_api.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/enum/enum_app.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/utils/delay_for_search.dart';
import 'package:savenote/utils/scan_barcode.dart';
import 'package:savenote/views/add_items_list.dart';
import 'package:savenote/widgets/not_found_search.dart';
import 'package:savenote/widgets/scan_modal.dart';

class AddItems extends StatefulWidget {
  final String type;
  const AddItems({Key? key, required this.type}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  List<Product> productsSuggestion = [];
  List<Product> products = [];
  bool _loading = false, searching = false, notFound = false;
  var _controller = TextEditingController();

  final _delay = DelayForSearch(milliseconds: 500);
  final productSearchRep = ProductSearchRep();
  void _deleteFunction(int index) {
    products.removeAt(index);
    setState(() {});
  }

  void _addFunction(Product product) {
    products.add(product);
    setState(() {});
  }

  void _addListProductFunction() async {
    await Provider.of<ProductList>(context, listen: false)
        .addProductList(products: products, type: widget.type);
    await Provider.of<ProductList>(context, listen: false)
        .submitProductsSetup( type: widget.type);
  }

  void _updateProductQuantityFunction(int index, double val) {
    products[index].quantity = val;
    setState(() {});
  }

  void _updateProductUnitFunction(int index, Unit val) {
    products[index].unit = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            text: 'Inventory: ',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: AppColors.TEXT_COLOR),
            children: <TextSpan>[
              TextSpan(
                text: (() {
                  if (widget.type == "Fridge") return "Setup your fridge";
                  if (widget.type == "Pantry") return "Setup your pantry";
                  if (widget.type == "Other") return "Setup your Freezer";
                  return "";
                }()),
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.TEXT_COLOR),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "Add fridge items...",
                    suffixIcon: searching && !notFound
                        ? IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            color: Colors.black45,
                            onPressed: () {
                              setState(() {
                                productsSuggestion = [];
                                searching = false;
                              });
                              _controller.clear();
                            },
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/ph_barcode.svg",
                                ),
                                onPressed: () async {
                                  var code = await scanBarcode(context);
                                  await scanModal(context, code);
                                } //do something,
                                ),
                          ),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.BORDER_COLOR),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: AppColors.BORDER_COLOR,
                        ),
                        borderRadius: searching && !notFound
                            ? BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0),
                              )
                            : BorderRadius.all(Radius.circular(24))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.BORDER_COLOR, width: 0.5),
                        borderRadius: searching && !notFound
                            ? BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0),
                              )
                            : BorderRadius.all(Radius.circular(24)))),
                onChanged: (val) {
                  _delay.run(() {
                    setState(() {
                      _loading = true;
                      searching = true;
                      notFound = false;
                    });
                    if (val == "") {
                      setState(() {
                        _loading = false;
                        searching = false;
                        productsSuggestion = [];
                      });
                    } else {
                      productSearchRep.search(val).then((value) {
                        List<dynamic> list = value["data"];

                        if (list.isEmpty) {
                          notFound = true;
                        }

                        productsSuggestion = list
                            .map((e) => new Product(
                            product_Name: e["product_Name"],
                            Categorie: e["Categorie"].toString(),
                            ingredients:
                            e["ingredients"].toString().split(",")))
                            .toList();
                        _loading = false;
                        setState(() {});
                      });
                    }
                  });
                },
              ),
              !searching
                  ? AddItemsList(
                      products: products,
                      deleteHandler: _deleteFunction,
                      quantityHandler: _updateProductQuantityFunction,
                      unitHandler: _updateProductUnitFunction, submitHandler: _addListProductFunction,)
                  : notFound
                      ? NotFoundSearch(
                          type: widget.type,
                          handelAdd: _addFunction,
                          clear: () {
                            setState(() {
                              productsSuggestion = [];
                              searching = false;
                            });
                            _controller.clear();
                          },
                        )
                      : Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: searching
                                  ? Border(
                                      left: BorderSide(
                                        color: AppColors.BORDER_COLOR,
                                        width: 0.5,
                                      ),
                                      top: BorderSide.none,
                                      right: BorderSide(
                                        color: AppColors.BORDER_COLOR,
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.BORDER_COLOR,
                                        width: 0.5,
                                      ))
                                  : Border.all(color: Colors.transparent)),
                          child: _loading
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 130,
                                      horizontal:
                                          (MediaQuery.of(context).size.width -
                                                  90) /
                                              2),
                                  child: CircularProgressIndicator(
                                    color: AppColors.PRIMARY_COLOR,
                                  ))
                              : Flex(direction: Axis.vertical, children: [
                                  Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(10.0),
                                          itemCount:
                                              productsSuggestion.length > 8
                                                  ? 7
                                                  : productsSuggestion.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                products.add(new Product(
                                                  product_Name:
                                                      productsSuggestion[index]
                                                          .product_Name,

                                                  Categorie:
                                                      productsSuggestion[index]
                                                          .Categorie,
                                                  ingredients:
                                                      productsSuggestion[index]
                                                          .ingredients,
                                                ));
                                                setState(() {
                                                  productsSuggestion = [];
                                                  searching = false;
                                                });
                                                _controller.clear();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 8, 0, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                        Icons.add_box_outlined),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      productsSuggestion[index]
                                                          .product_Name
                                                          .length >
                                                          25
                                                          ? productsSuggestion[
                                                      index]
                                                          .product_Name
                                                          .substring(
                                                          0, 25) +
                                                          "..."
                                                          : productsSuggestion[
                                                      index]
                                                          .product_Name,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ]),
                        ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
