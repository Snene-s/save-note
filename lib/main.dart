import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:savenote/Services/app.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/screenUtils.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/models/grocery_list.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/models/product_list.dart';
import 'package:savenote/models/shopping_list.dart';
import 'package:savenote/storage/local_storage.dart';
import 'package:savenote/storage/secure_local_storage.dart';
import 'package:savenote/views/home.dart';
import 'package:savenote/views/welcome.dart';
import 'package:savenote/widgets/dismiss_keyboard.dart';

import 'storage/storage_keys.dart';

String? jwt;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.intializeSharedPreferences();
  jwt = await SecureLocalStorage.getItem(TOKEN);

  runApp(MyApp());
}

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Household()),
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => GroceryList()),
        ChangeNotifierProvider(create: (_) => ShoppingList()),
      ],
      child: DismissKeyboard(
        child: MaterialApp(
          title: 'Savenote app',
          theme: ThemeData(
              accentColor: AppColors.PRIMARY_COLOR,
              primaryColorLight: AppColors.PRIMARY_COLOR,
              focusColor: AppColors.PRIMARY_COLOR,
              iconTheme: IconThemeData(color: Colors.black),
              primaryColor: AppColors.PRIMARY_COLOR,
              splashColor: AppColors.PRIMARY_COLOR,
              dividerColor: AppColors.PRIMARY_COLOR,
              inputDecorationTheme: InputDecorationTheme(
                focusColor: AppColors.PRIMARY_COLOR,
              ),
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder()
                // ZoomPageTransitionsBuilder
              })
              // brightness: Brightness.light,
              ),
          home: LoadingScreen(),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  LoadingScreenState createState() => new LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  bool showImage = false;

  late Widget screenToBeShown;

  @override
  void initState() {
    super.initState();
    screenGetter();
    getPackageInfoDetails();
    // if (Platform.isAndroid) {
  }

  getPackageInfoDetails() async {
    await Future.delayed(const Duration(milliseconds: 250));

    setState(() {});
  }

  Future<void> screenGetter() async {
    final res = await Future.wait([
      getStartUpScreen(context: context),
      Future.delayed(const Duration(milliseconds: 2750))
    ]);

    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 2000),
        child: res[0],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: Center(
            child: Text(
          "Savenote",
          style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),
        )));
  }
}
