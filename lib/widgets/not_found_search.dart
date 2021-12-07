import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/views/inventory_setup/add_new_item.dart';

class NotFoundSearch extends StatelessWidget {
  final String type;
  final Function? clear;
  final Function? handelAdd;
  const NotFoundSearch({Key? key, required this.type, this.clear, this.handelAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Image.asset(
              'assets/images/not_found_img.png',

              height: MediaQuery.of(context).size.height >
                  MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.height / 3.4
                  : MediaQuery.of(context).size.width / 3.4,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Oops ... We couldn’t \n find this product",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
          ),
          SizedBox(
            height: 20,
          ),
          Text("But don’t worry! You can easily add it \n to your inventory ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  height: 2.131,
                  color: Color.fromRGBO(102, 102, 102, 1))),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Ink(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNewItem(type: type,handlerConfirm: handelAdd,)));
                  clear!();
                },
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add item",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
