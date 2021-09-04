import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/views/forgot_password/create_new_password.dart';
import 'package:savenote/widgets/widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false, completed = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleStr: "Verification",
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
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
                  "Please enter the verification code \nsend to your email address",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 5,
                      animationType: AnimationType.fade,
                      validator: (v) {},
                      pinTheme: PinTheme(
                        activeColor: AppColors.PRIMARY_COLOR,
                        inactiveColor: AppColors.BORDER_COLOR,
                        selectedColor: AppColors.BORDER_COLOR,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        borderWidth: 1.5,
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 3,
                        )
                      ],
                      beforeTextPaste: (text) {
                        return int.tryParse(text!) != null && text.length == 5;
                      },
                      onCompleted: (v) {
                        completed = true;
                        setState(() {});
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                          completed = false;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Resend code",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: AppColors.PRIMARY_COLOR, offset: Offset(0, -1.5))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor:  AppColors.PRIMARY_COLOR,
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 22 + 8,
              ),
              InkWell(
                enableFeedback: true,
                onTap: () {
                  if (completed && !hasError) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewPassword()));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                  decoration: BoxDecoration(
                    color: !completed || hasError
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
        )));
  }
}
