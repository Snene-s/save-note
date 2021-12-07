import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/constants/common_style.dart';
import 'package:savenote/models/member.dart';
import 'package:savenote/models/household_model.dart';
import 'package:savenote/widgets/widget.dart';

class InviteMember extends StatefulWidget {
  const InviteMember({Key? key}) : super(key: key);

  @override
  _InviteMemberState createState() => _InviteMemberState();
}

class _InviteMemberState extends State<InviteMember> {
  final _formKey = GlobalKey<FormState>();
  String email = "", name = "", phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleStr: "Invite a member",
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
                  "Name",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      name = val;
                      setState(() {});
                    },
                    validator: (val){
                      return (val!.length<2)? "Name must be longer than two characters":null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "Enter member name...")),
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
                      setState(() {});
                    },
                    validator: (val) {
                      return val!.isEmpty
                          ? "email isEmpty"
                          : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? "Enter valid email"
                              : null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "Enter member email...")),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    onChanged: (val) {
                      phone = val;
                      setState(() {});
                    },
                    validator: (val) {
                      var isDigitsOnly = int.tryParse(val.toString());
                      return isDigitsOnly == null
                          ? 'Input needs to be digits only'
                          : null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: CommonStyle.textFieldStyle(
                        hintTextStr: "Enter member phone...")),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Ink(
                    height: 50,
                    decoration: BoxDecoration(
                      color: email.isNotEmpty &&
                              phone.isNotEmpty &&
                              name.isNotEmpty
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (name.isNotEmpty &&
                            email.isNotEmpty &&
                            phone
                                .isNotEmpty) if (_formKey.currentState!
                            .validate()) {
                          Provider.of<Household>(context, listen: false)
                              .addMember(
                                  name: name, email: email, phone: phone);
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Text(
                          "Add member",
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
}
