import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/models/auth_model.dart';

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
                  authModel.user.email,
                  style: TextStyle(fontSize: 13),
                ),
                accountName: Text(authModel.user.name),
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
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      authModel.user.imgUrl,
                    ))),
            ListTile(
              leading: Icon(
                Icons.inventory_2_sharp,
                color: Colors.black,
              ),
              title: Text("Inventory"),
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.black,
              ),
              dense: true,
              title: Text("Grocery List"),
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
            ),
          ],
        );
      },
    ));
  }
}
