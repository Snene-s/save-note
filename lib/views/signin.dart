import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/views/create_household.dart';
import 'package:savenote/views/forgot_password/forgot_password.dart';
import 'package:savenote/widgets/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Sign in ",
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      email = val;
                      setState(() {
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "Enter your email...")),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      password = val;
                      setState(() {
                      });
                    },
                    obscureText: !_showPassword,
                    decoration: CommonStyle.textFieldStyle(
                      hintTextStr: "Enter your password...",
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _showPassword ? Colors.blue : Colors.grey,
                          )),
                    )),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));},
                      child: Text("Forget password?",
                          style: TextStyle(color: AppColors.PRIMARY_COLOR)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    email.isNotEmpty && password.isNotEmpty
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateHousehold()))
                        : null;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                    decoration: BoxDecoration(
                      color: email.isNotEmpty && password.isNotEmpty
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Log in",
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
        ),
      ),
    );
  }
}
