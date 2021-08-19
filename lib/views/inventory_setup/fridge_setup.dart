import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/Services/product_search_api.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/product.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/views/inventory_setup/list_inventory_view.dart';
import 'package:savenote/views/inventory_setup/pantry_setup.dart';
import 'package:savenote/widgets/widget.dart';

class FridgeSetup extends StatefulWidget {
  const FridgeSetup({Key? key}) : super(key: key);

  @override
  _FridgeSetupState createState() => _FridgeSetupState();
}

class DelayForSearch {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DelayForSearch({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _FridgeSetupState extends State<FridgeSetup> {
  List<Product> productsSuggestion = [];
  bool _loading = false, searching = false, notFound = false;
  var _controller = TextEditingController();

  final _delay = DelayForSearch(milliseconds: 500);
  final productSearchRep = ProductSearchRep();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Step 1/3",
        action: GestureDetector(
            onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantrySetup()));},
            child: Text("skip",
                style:
                    TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16))),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "Search anything...",
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
                        : Icon(
                            Icons.qr_code_2_outlined,
                            color: AppColors.PRIMARY_COLOR,
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
                        if (value["totalHits"] == 0) {
                          notFound = true;
                        }
                        productsSuggestion = value["data"];
                        _loading = false;
                        setState(() {});
                      });
                    }
                  });
                },
              ),
              !searching
                  ? ListInventory()
                  : notFound
                      ? NotFoundPage()
                      : Container(
                          height: 320,
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
                                  margin: EdgeInsets.all(60),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 63),
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.PRIMARY_COLOR,
                                      )))
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
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 8, 0, 8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Provider.of<ProductList>(
                                                          context,
                                                          listen: false)
                                                      .addProduct(
                                                          fdcId:
                                                              productsSuggestion[
                                                                      index]
                                                                  .fdcId,
                                                          description:
                                                              productsSuggestion[
                                                                      index]
                                                                  .description,
                                                          foodCategory:
                                                              productsSuggestion[
                                                                      index]
                                                                  .foodCategory);
                                                  setState(() {
                                                    productsSuggestion = [];
                                                    searching = false;
                                                  });
                                                  _controller.clear();
                                                },
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
                                                                  .description
                                                                  .length >
                                                              25
                                                          ? productsSuggestion[
                                                                      index]
                                                                  .description
                                                                  .substring(
                                                                      0, 25) +
                                                              "..."
                                                          : productsSuggestion[
                                                                  index]
                                                              .description,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ]),
                        )
            ],
          ),
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: Image.asset(
              'assets/images/not_found_img.png',
              width: 231.26,
              height: 221,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Oops ... We couldn’t \n find this product",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
          ),
          SizedBox(
            height: 20,
          ),
          Text("But don’t worry! You can easily add it \n to your inventory ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  height: 2.131,
                  color: Color.fromRGBO(102, 102, 102, 1))),
          SizedBox(
            height: 20,
          ),
          Container(
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
        ],
      ),
    );
  }
}
