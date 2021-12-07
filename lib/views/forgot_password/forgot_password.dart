import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/views/forgot_password/verification.dart';
import 'package:savenote/widgets/circular_indicator.dart';
import 'package:savenote/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  final _text = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, authModel, child) {
      if (!authModel.loading) {
        return Scaffold(
            appBar: CustomAppBar(
              titleStr: "Forgot password",
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Center(
                      child: Container(
                        child: SvgPicture.asset(
                            'assets/images/password2_img.svg',
                            height: MediaQuery.of(context).size.height >
                                    MediaQuery.of(context).size.width
                                ? MediaQuery.of(context).size.height / 5
                                : MediaQuery.of(context).size.width / 5),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    Center(
                      child: Text(
                        "Please enter your email address to\nreceive an verification code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _text,
                        onChanged: (val) {
                          email = val;
                          _validate = false;
                          setState(() {});
                        },
                        decoration: CommonStyle.textFieldStyle(
                          hintTextStr: "Enter your email...",
                          errorMessage: _validate ? 'Enter valid email' : null,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: email.isEmpty
                              ? AppColors.SECONDARY_COLOR
                              : AppColors.PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 50,
                        child: InkWell(
                          onTap: () async {
                            if (email.isNotEmpty) {
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_text.text)) {
                                setState(() {
                                  _validate = true;
                                });
                              } else {
                                final forgotState =
                                    await authModel.forgotPasswordStepOne(
                                  email: email,
                                );
                                if (forgotState['status']) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Verification()));
                                } else {
                                  var msg = forgotState["message"];
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(msg.toString())));
                                }
                              }
                            }
                          },
                          child: Center(
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
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }
      return CircularIndicator();
    });
  }
}
