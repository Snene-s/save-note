import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/Services/product_search_api.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/utils/delay_for_search.dart';
import 'package:savenote/utils/scan_barcode.dart';
import 'package:savenote/views/inventory_setup/list_inventory_view.dart';
import 'package:savenote/views/inventory_setup/other_setup.dart';
import 'package:savenote/widgets/custom_popup.dart';
import 'package:savenote/widgets/not_found_search.dart';
import 'package:savenote/widgets/scan_modal.dart';
import 'package:savenote/widgets/widget.dart';

class FridgeSetup extends StatefulWidget {
  const FridgeSetup({Key? key}) : super(key: key);

  @override
  _FridgeSetupState createState() => _FridgeSetupState();
}

class _FridgeSetupState extends State<FridgeSetup> {
  List<Product> productsSuggestion = [];
  bool _loading = false, searching = false, notFound = false;
  var _controller = TextEditingController();

  final _delay = DelayForSearch(milliseconds: 500);
  final productSearchRep = ProductSearchRep();
  bool keyIsFirstLoaded = true;

  @override
  void initState() {
    super.initState();

    if (keyIsFirstLoaded)
      WidgetsBinding.instance!.addPostFrameCallback((_) => customPopup(
              context,
              [
                "To search for products, you can type its name or scan the barcode by pressing on icon.",
                "After choosing a product you can set its quantity and measurement unit.",
                "Swipe to delete a product from the inventory list."
              ],
              'assets/images/QR Code-rafiki 1.svg',
              "Next", () {
            Navigator.of(context).pop();
          }));
    keyIsFirstLoaded = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Step 1/3",
        action: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OtherSetup()));
            },
            child: Text("skip",
                style:
                    TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16))),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
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

                                    var response =
                                        await Provider.of<ProductList>(context,
                                                listen: false)
                                            .searchByCode(code:code,type: "Fridge");

                                    if (response['status']) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("product added")));
                                    } else {
                                      var msg = response["message"];
                                      notFound=true;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(msg.toString())));
                                      setState(() {
                                      });
                                    }
                                  }),
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
              ),
              !searching
                  ? ListInventory(
                      type: "Fridge",
                    )
                  : notFound
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: NotFoundSearch(
                            type: "Fridge",
                            clear: () {
                              setState(() {
                                productsSuggestion = [];
                                searching = false;
                              });
                              _controller.clear();
                            },
                          ),
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
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    child: CircularProgressIndicator(
                                      color: AppColors.PRIMARY_COLOR,
                                    ),
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
                                                Provider.of<ProductList>(
                                                        context,
                                                        listen: false)
                                                    .addProduct(
                                                        product_Name:
                                                            productsSuggestion[
                                                                    index]
                                                                .product_Name,
                                                        Categorie:
                                                            productsSuggestion[
                                                                    index]
                                                                .Categorie,
                                                        ingredients:
                                                            productsSuggestion[
                                                                    index]
                                                                .ingredients,
                                                        type: "Fridge");
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
