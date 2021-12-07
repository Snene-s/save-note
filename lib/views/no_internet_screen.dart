
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savenote/Services/app.dart';
import 'package:savenote/constants/app_colors.dart';


class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreenContent();
  }
}

class NoInternetScreenContent extends StatefulWidget {
  var isProcessing = false;

  @override
  _NoInternetScreenContentState createState() =>
      _NoInternetScreenContentState();
}

class _NoInternetScreenContentState extends State<NoInternetScreenContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
          child: Center(
            child: WillPopScope(
              onWillPop: () async {
                 return Future.value(false);
              },
              child: AlertDialog(
                title: Text("No Internet Connection"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Please connect to stable internet connection and try again.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      width: double.maxFinite,
                      child: RaisedButton(
                        color: AppColors.PRIMARY_COLOR,
                        child: widget.isProcessing
                            ? SpinKitThreeBounce(
                          size: 25,
                          duration: Duration(milliseconds: 800),
                          color: Colors.white,
                        )
                            : Text("TRY AGAIN"),
                        onPressed: () async {
                          setState(() {
                            widget.isProcessing = true;
                          });

                          Widget screen = await getStartUpScreen();
                          if (!(screen is NoInternetScreen)) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return screen;
                              }),
                                  (Route<dynamic> route) => false,
                            );
                          } else {
                            Future.delayed(
                                Duration(milliseconds: 1000),
                                    () => {
                                  setState(() {
                                    widget.isProcessing = false;
                                  })
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showModal(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: AlertDialog(
            title: Text("No Internet Connection"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Please connect to stable internet connection and try again.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  width: double.maxFinite,
                  child: RaisedButton(
                    color: AppColors.PRIMARY_COLOR,
                    child: widget.isProcessing
                        ? SpinKitThreeBounce(
                      size: 25,
                      duration: Duration(milliseconds: 800),
                      color: Colors.white,
                    )
                        : Text("TRY AGAIN"),
                    onPressed: () async {
                      setState(() {
                        widget.isProcessing = true;
                      });
                      Widget screen = await getStartUpScreen();
                      if (!(screen is NoInternetScreen)) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return screen;
                          }),
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          widget.isProcessing = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
