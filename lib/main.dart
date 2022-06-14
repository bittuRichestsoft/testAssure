import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/view/IntroScreens/HomePag.dart';
import 'package:thoroughio/view/IntroScreens/Intro1.dart';
import 'package:thoroughio/view/home/home_page.dart';
import 'package:thoroughio/view/home/home_second.dart';
import 'package:thoroughio/view/login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.app_gradient_start_color));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  getAuthToken();
}

String authToken, intro;

getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  authToken = prefs.getString(AppStrings.authToken);
  intro = prefs.getString(AppStrings.intro);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  SpalshPage createState() => SpalshPage();
}

class SpalshPage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Always Assure',
        home:
//        (intro == "" || intro == "null" || intro == null)
        (authToken == "" || authToken == "null" || authToken == null)
            ? Intro1() :  HomeSecond/*HomePage*/(authToken)
/*            : (authToken == "" || authToken == "null" || authToken == null)
                ? LoginPage()
                : HomePage(authToken)*/
    );
  }
}
