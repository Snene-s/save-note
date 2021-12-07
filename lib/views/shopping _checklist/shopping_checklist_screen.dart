import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:savenote/models/auth_model.dart';
import 'package:savenote/views/grocery_screen/list_grocery.dart';
import 'package:savenote/views/shopping%20_checklist/cameraScreen.dart';
import 'package:savenote/views/shopping%20_checklist/list_of_shopping.dart';
import 'package:savenote/views/shopping%20_checklist/manual_entry.dart';
import 'package:savenote/widgets/custom_drawer.dart';

class ChoppingChecklist extends StatelessWidget {
  const ChoppingChecklist({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Provider.of<AuthModel>(context, listen: false).getUser();
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Shopping Checklist",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: AppColors.TEXT_COLOR),
          ),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(children: [
            ListOfShopping(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                openPopup(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Complete trip",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ]),
        ));
  }
}
void openPopup(context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {

        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),

            content: Container(
              height:200 ,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){ Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraScreen()));},
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/crown.svg",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Scan Receipt",style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),)
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(child: Text("or")),
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.PRIMARY_COLOR,width: 0.5)
                        ),
                        child: InkWell(
                          onTap: (){ Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManualEntry(type: "Fridge")));},
                          child: Text("Manual entry",style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: AppColors.PRIMARY_COLOR) ,),
                        )),
                  ),
                ],
              ),
            )
        );
      });

}