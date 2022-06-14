import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/view/login/login_page.dart';

class GlobalUtility {

 /* Future<File> filepicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;
    if (result != null) {
      file = File(result.files[0].path!);
    }
    else {}
    debugPrint(" picked file ${file!.path}");
    return file;
  }
*/

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => 0.0) != null;
  }
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


  // set sharedpreferences empty
/*  void setSessionEmpty(BuildContext context)  async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage(),), (route) => false,);
  }*/

  // loader
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Please wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showToast(String message,BuildContext context) {
/*
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
*/
    final snackBar = SnackBar(

      duration: Duration(seconds: 1),
      content: Text(message),
      /*  action: SnackBarAction(
        label: 'ok',

        onPressed: () {

          // Some code to undo the change.

        },
      ),*/
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
debugPrint("only print  $message");  }

void showSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(

    duration: Duration(seconds: 1),
    content: Text(message),
    /*  action: SnackBarAction(
        label: 'ok',

        onPressed: () {

          // Some code to undo the change.

        },
      ),*/
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
  void setData(String authToken) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppStrings.authToken, authToken);
    debugPrint("authToken=$authToken");
  }

  void setIntro(BuildContext context) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //  prefs.setString(AppStrings.intro,"true");

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(),));

    debugPrint("intro=true");
  }
  void clearAuthToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppStrings.authToken, "");
  }




}
