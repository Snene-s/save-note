import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/views/grocery_screen/grocery_screen.dart';
import 'package:savenote/views/inventory_screen/inventory_screen.dart';
import 'package:savenote/views/welcome.dart';
extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(child: Consumer<AuthModel>(
      builder: (context, authModel, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(
                authModel.user!.email,
                style: TextStyle(fontSize: 13),
              ),
              accountName: Text(authModel.user?.username!=null ? authModel.user!.username :"Guest"),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(92, 214, 81, 1),
                      Color.fromRGBO(152, 231, 109, 0.8),
                    ]),
              ),
              currentAccountPicture: CircleAvatar(
                  radius: 40.2,
                  backgroundColor:
                      authModel.user!.color.toColor(),
                  child: Text(
                    authModel.user?.username!=null ? authModel.user!.username.substring(0, 2).toUpperCase():"GE",
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.inventory_2_sharp,
                color: Colors.black,
              ),
              title: Text("Inventory"),
              onTap: ()async {
                var ids=  await Provider.of<AuthModel>(context, listen: false).householdId;
                Provider.of<ProductList>(context, listen: false).fetchInventory(ids[0]);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InventoryScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.black,
              ),
              dense: true,
              title: Text("Grocery List"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroceryScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              title: Text("Shopping Mode"),
              dense: true,
            ),
            ListTile(
              leading: Icon(
                Icons.analytics,
                color: Colors.black,
              ),
              title: Text("Analyze"),
            ),
            ListTile(
              leading: Icon(
                Icons.schedule_outlined,
                color: Colors.black,
              ),
              title: Text("Schedule"),
              dense: true,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("Settings"),
              dense: true,
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.black,
              ),
              title: Text("About"),
              dense: true,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text("Logout"),
              dense: true,
              onTap: () async {
                await Provider.of<AuthModel>(context, listen: false).logout();
                await Provider.of<Household>(context, listen: false).logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    ));
  }
}
