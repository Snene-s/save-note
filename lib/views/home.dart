import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/widgets/custom_drawer.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthModel>(context, listen: false).getUser();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: AppColors.TEXT_COLOR),
        ),

        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,),
    );
  }
}
