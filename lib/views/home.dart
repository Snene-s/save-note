import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/views/create_household.dart';
import 'package:savenote/widgets/circular_indicator.dart';
import 'package:savenote/widgets/custom_drawer.dart';

import 'package:savenote/widgets/spline_chart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final fakeData = [
    StateData(key: "Min", value: "65"),
    StateData(key: "Max", value: "217"),
    StateData(key: "Total", value: "1102"),
    StateData(key: "Average", value: "110"),
  ];
  @override
  initState() {
    List<String> householdId =
        Provider.of<AuthModel>(context, listen: false).getHouseHoldId();
    if (householdId.isNotEmpty)
      print(householdId);
      Provider.of<Household>(context, listen: false)
          .getHousehold(id: householdId[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, authModel, child) {
      return Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Savenote",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  color: AppColors.TEXT_COLOR),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
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
                  Ink(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 1, // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Ink(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Household members",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Ink(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateHousehold()));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Manage",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            color: Colors.black)),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 8.4,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Consumer<Household>(
                              builder: (context, membersModel, child) {
                            if (membersModel.loading)
                              return Container(
                                child: CircularIndicator(),
                              );

                            if (membersModel.members.isEmpty)
                              return Center(child: Text("no data found"));
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 4),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.BORDER_COLOR,
                                    radius: 24,
                                    child: CircleAvatar(
                                        radius: 23.9,
                                        backgroundColor: toColorExtension(membersModel
                                            .members[index].color)
                                            ,
                                        child: Text(
                                          membersModel.members[index].username
                                              .substring(0, 2)
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: membersModel.members.length,
                            );
                          })),
                    ]),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 1, // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Food expenditure",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Discover more",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        color: Colors.black)),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: SplineChart(),
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          height: 110,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(112, 224, 102, 1),
                                  Color.fromRGBO(153, 224, 102, 1),
                                ],
                              )),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                fakeData[index].key,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '\$',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: fakeData[index].value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 1, // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/medal.svg",
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                            "Congratulation! you spend 100\$ less\nthis week  ")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class StateData {
  String key;
  String value;
  StateData({required this.key, required this.value});
}


 toColorExtension(String color)  {

    var hexColor = color.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    else{
      return Color(0xFFB0BEC5);
    }

}