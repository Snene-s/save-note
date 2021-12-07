import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/views/create_household.dart';
import 'package:savenote/widgets/circular_indicator.dart';
import 'package:savenote/widgets/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _email = "", _password = "", _username = "", _repeatPassword = "";

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthModel>(builder: (context, authModel, child) {
      if (!authModel.loading) {
        return Scaffold(
          appBar: CustomAppBar(
            titleStr: "Create your account ",
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
                      "Username",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Username is required" : null;
                        },
                        onChanged: (val) {
                          _username = val;
                          setState(() {});
                        },
                        decoration: CommonStyle.textFieldStyle(
                            hintTextStr: "Enter your username...")),
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
                        validator: (val) {
                          return val!.isEmpty
                              ? "Email is required"
                              : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? "Enter valid Email"
                                  : null;
                        },
                        onChanged: (val) {
                          _email = val;
                          setState(() {});
                        },
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
                        validator: (val) {
                          return !validateStructure(val!)
                              ? "Password must meet complexity requirements"
                              : null;
                        },
                        onChanged: (val) {
                          _password = val;
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
                      height: 20,
                    ),
                    Text(
                      "Repeat your password",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val) {
                        return _password != _repeatPassword
                            ? "Conformation password does not match"
                            : null;
                      },
                      onChanged: (val) {
                        _repeatPassword = val;
                        setState(() {});
                      },
                      obscureText: true,
                      decoration: CommonStyle.textFieldStyle(
                          hintTextStr: "Repeat your password..."),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          color: _email.isEmpty ||
                                  _password.isEmpty ||
                                  _username.isEmpty ||
                                  _repeatPassword.isEmpty
                              ? AppColors.SECONDARY_COLOR
                              : AppColors.PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (_email.isNotEmpty &&
                                _password.isNotEmpty &&
                                _username.isNotEmpty &&
                                _repeatPassword.isNotEmpty) {
                              if (_formKey.currentState!.validate()) {
                                final signUpState = await authModel.submitSignUp(
                                    email: _email,
                                    password: _password,
                                    userName: _username,
                                    passwordConfirmation: _repeatPassword);
                                if (signUpState['status']) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CreateHousehold(),
                                  ));
                                } else {
                                  var msg = signUpState["message"];
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(msg.toString())));
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              "Start",
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
      }
      return CircularIndicator();
    });
  }
}
