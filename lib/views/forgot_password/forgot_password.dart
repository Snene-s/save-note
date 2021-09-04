import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/views/forgot_password/verification.dart';
import 'package:savenote/widgets/widget.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email="";
  final _text = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Forgot password",
      ),
      body:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/30 ,),
              Center(
                child: Container(
                  child: SvgPicture.asset('assets/images/inventory_setup_img.svg',
                      height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 5
                          : MediaQuery.of(context).size.width / 5),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/35 ,),
              Center(
                child: Text(
                  "Please enter your email address to\nreceive an verification code",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.grey,height:1.5),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/20 ,),
              Text(
                "Email",
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _text,
                  onChanged: (val) {
                    email = val;
                    _validate=false;
                    setState(() {
                    });
                  },

                  decoration: CommonStyle.textFieldStyle(
                      hintTextStr: "Enter your email...",errorMessage: _validate ? 'Enter valid email' : null,)),
              SizedBox(height: MediaQuery.of(context).size.height/20 ,),
              InkWell(
                enableFeedback:true,
                onTap: () {
                  if (email.isNotEmpty){
                   if( !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_text.text)) {setState(() {
                        _validate=true;
                        });}
                   else{
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context) => Verification()));
                   }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                  decoration: BoxDecoration(
                    color: email.isEmpty
                        ? AppColors.SECONDARY_COLOR
                        : AppColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
