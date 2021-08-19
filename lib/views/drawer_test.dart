import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/widgets/custom_drawer.dart';
class TestDrawer extends StatelessWidget {
  const TestDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthModel>(context, listen: false).getUser();
    return Scaffold(
        appBar:  AppBar(title: Text("hi"),),
        drawer: CustomDrawer()
    );
  }
}
