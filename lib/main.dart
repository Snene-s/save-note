import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/models/member_list.dart';
import 'package:savenote/models/product_list.dart';
//import 'package:savenote/views/signin.dart';
import 'package:savenote/views/welcome.dart';
import 'package:savenote/widgets/dismiss_keyboard.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build (BuildContext context)  {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemberList()),
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => ProductList()),
      ],
      child: DismissKeyboard(
        child: MaterialApp(
          title: 'Savenote app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:  Welcome(),
        ),
      ),
    );
  }
}
