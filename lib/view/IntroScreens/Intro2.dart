
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/global_utility.dart';

import 'Intro3.dart';

class Intro2 extends StatefulWidget {

  @override
  _Intro2State createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Image.network("https://alwaysassure.in/mobile-app/assets/banners/ban2.png",
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height +MediaQuery.of(context).padding.top  ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  skipButton(),
                  nextButton()

                ],
              ),
            ),
          )

        ],
      ),
    );

  }

  Widget skipButton()
  {
    return Container(

      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * AppWidgetSize.appButtonSize,
//     width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *AppWidgetSize.appBorderRadius)),
          color: AppColor.app_theme_color
      ),
      child: InkWell(
        onTap:() {
          GlobalUtility().setIntro(context);

        },
        child: Text(
          "Skip",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appTitleFontSize,
              color: AppColor.white,
              fontFamily:AppStrings.NotoBold
          ),

        ),
      ),
    );
  }

  Widget nextButton()
  {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * AppWidgetSize.appButtonSize,
//     width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *AppWidgetSize.appBorderRadius)),
          color: AppColor.app_theme_color
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Intro3(),));
        },

        child: Text(
          "Next",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appTitleFontSize,
              color: AppColor.white,
              fontFamily:AppStrings.NotoBold
          ),

        ),
      ),
    );
  }
}