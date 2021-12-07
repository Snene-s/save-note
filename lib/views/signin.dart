import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/views/forgot_password/forgot_password.dart';
import 'package:savenote/views/home.dart';
import 'package:savenote/widgets/circular_indicator.dart';
import 'package:savenote/widgets/popup_connection_status.dart';
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

  bool _isConnected = true;
  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        popupConnectionStatus(context);
      });
      setState(() {
        _isConnected = false;
      });
      print(err);
    }
  }

  @override
  initState() {
    _checkInternetConnection();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, authModel, child) {
      if (!authModel.loading) {
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
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        onChanged: (val) {
                          email = val;
                          setState(() {});
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
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        onChanged: (val) {
                          password = val;
                          setState(() {});
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
                                color:
                                    _showPassword ? Colors.blue : Colors.grey,
                              )),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forget password?",
                              style: TextStyle(color: AppColors.PRIMARY_COLOR)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          color: email.isNotEmpty && password.isNotEmpty
                              ? AppColors.PRIMARY_COLOR
                              : AppColors.SECONDARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (email.isNotEmpty && password.isNotEmpty) {
                              final loginState = await Provider.of<AuthModel>(
                                      context,
                                      listen: false)
                                  .submitLogin(
                                      email: email, password: password);

                              if (loginState['status']) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                              } else {
                                var msg = loginState["message"];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(msg.toString())));
                              }
                            }
                          },
                          child: Center(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return CircularIndicator();
      }
    });
  }
}
