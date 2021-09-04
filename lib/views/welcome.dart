import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/views/create_household.dart';
import 'package:savenote/views/signin.dart';
import 'package:savenote/views/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/9,
              ),
              Center(
                child: Text(
                  'Savenote',
                  style: TextStyle(
                      fontSize: 49,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: AppColors.TEXT_COLOR,
                      letterSpacing: -0.3),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/18,
              ),
              Container(
                child: SvgPicture.asset(
                  'assets/images/welcome.svg',
                  semanticsLabel: "Welcome picture",
                  height:  MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.height / 4
                      : MediaQuery.of(context).size.width / 4,
                ),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height/23,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    color: AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: AppColors.PRIMARY_COLOR),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/25,
              ),
              Text(
                "Or ",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: AppColors.TEXT_COLOR),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateHousehold()));
                },
                child: Container(
                    alignment: Alignment.center,
                    width: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    decoration: BoxDecoration(
                      color: HexColor("#F4F3F3"),
                      border: Border.all(width: 0.5,color: Color.fromRGBO(153, 153, 153, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icongoogle.png',
                            width: 24, height: 24),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Continue with Google",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(102, 102, 102, 1)
                            ))
                      ],
                    )),
              ),

            ],
          ),
        ),

    );
  }
}
