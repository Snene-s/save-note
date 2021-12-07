import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/views/inventory_screen/add_items.dart';
import 'package:savenote/views/inventory_screen/list_Inventory%20_with_notification.dart';
import 'package:savenote/widgets/custom_drawer.dart';
import 'package:savenote/widgets/custom_popup.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool keyIsFirstLoaded = true;

  int index = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    if (keyIsFirstLoaded)
      WidgetsBinding.instance!.addPostFrameCallback((_) => customPopup(
          context,
          [
            "You will get a notification on how many days left an items reach its expiration date",
            "If you have an expired food, swipe to dismiss it",
          ],
          'assets/images/healthy_option.svg',
          "Next", () {

        customPopup(
            context,
            [
              "Update quantity by tapping on the quantity field of any product.",
              "If you have an expired food, swipe to mark it as thrown out. ",
              "Add items by clicking on \"+\" icon."
            ],
            'assets/images/swipe_options.svg',
            "Okay, got it", () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }));
    keyIsFirstLoaded = false;
    _tabController.addListener(() {

      setState(() {
        index = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthModel>(context, listen: false).getUser();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Inventory",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: AppColors.TEXT_COLOR),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 10, 0),
            child: IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddItems(
                                type: (() {
                              if (index == 0) return "Fridge";
                              if (index == 1) return "Other";
                              if (index == 2) return "Pantry";
                              return "";
                            }()))));
              },
            ),
          )
        ],
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: EdgeInsets.zero,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    automaticIndicatorColorAdjustment: true,
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.PRIMARY_COLOR,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.only(bottom: 2),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: false,
                    dragStartBehavior: DragStartBehavior.start,
                    onTap: (i) {
                      index = i;
                      setState(() {});
                    },
                    indicator: index == 2
                        ? BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)))
                        : index == 0
                            ? BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)))
                            : BoxDecoration(color: AppColors.PRIMARY_COLOR),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: double.maxFinite,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.PRIMARY_COLOR),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                          child: Text("Fridge"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal:
                                    BorderSide(color: AppColors.PRIMARY_COLOR)),
                          ),
                          alignment: Alignment.center,
                          child: Text("Freezer"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: double.maxFinite,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.PRIMARY_COLOR),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          child: Text("Pantry"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height -
                        150, //height of TabBarView

                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Container(
                                child: ListInventoryWithNotification(
                              type: "Fridge",
                            )),
                          ),
                          SingleChildScrollView(
                            child: Container(
                                child: ListInventoryWithNotification(
                              type: "Other",
                            )),
                          ),
                          SingleChildScrollView(
                            child: Container(
                                child: ListInventoryWithNotification(
                              type: "Pantry",
                            )),
                          ),
                        ]))
              ]),
        ),
      ),
    );
  }
}
