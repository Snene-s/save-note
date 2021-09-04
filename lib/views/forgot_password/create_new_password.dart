import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/views/home.dart';
import 'package:savenote/widgets/widget.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _password = "", _repeatPassword = "";
  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Create new password",
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Center(
                  child: Container(
                    child: SvgPicture.asset(
                        'assets/images/inventory_setup_img.svg',
                        height: MediaQuery.of(context).size.height >
                                MediaQuery.of(context).size.width
                            ? MediaQuery.of(context).size.height / 5
                            : MediaQuery.of(context).size.width / 5),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Center(
                  child: Text(
                    "Set your new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5),
                  ),
                ),
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
                            color: _showPassword ? Colors.blue : Colors.grey,
                          )),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Repeat your password",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
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
                InkWell(
                  onTap: () {
                    if (_password.isNotEmpty && _repeatPassword.isNotEmpty) {
                      if (_formKey.currentState!.validate())
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                    decoration: BoxDecoration(
                      color: _password.isEmpty || _repeatPassword.isEmpty
                          ? AppColors.SECONDARY_COLOR
                          : AppColors.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Reset your password",
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
