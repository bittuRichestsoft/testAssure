
import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/global_utility.dart';

import 'Intro2.dart';

class Intro1 extends StatefulWidget {

  @override
  _Intro1State createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {

  int _currentPage = 0;
  Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

 // final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

var indxPage=0;
  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo( textColor : Colors.blue),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.stacked, textColor : Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.horizontal, textColor : Colors.green),
    ),
  ];


  bool end = false;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage == 2) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }
      if (end == false) {
        _currentPage++;
      } else {
      //  _currentPage--;
        _currentPage = 0;
      //  end = false;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 4000),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
           _buildPageView(),
          _buildCircleIndicator(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(child: nextButton(),
                  visible: false,) ,
                  skipButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _buildPageView() {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height  + MediaQuery.of(context).padding.top - kToolbarHeight,
      child: PageView.builder(
          itemCount: _pages.length,
          controller: _pageController,
          physics: new AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
          if(index==0)
            {
              return Image.network("https://alwaysassure.in/mobile-app/assets/banners/ban1.png",
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height   );
            }
 else if(index==1)
     {
       return Image.network("https://alwaysassure.in/mobile-app/assets/banners/ban2.png",
           width: MediaQuery.of(context).size.width ,
           height: MediaQuery.of(context).size.height /*+MediaQuery.of(context).padding.top*/  );
     }
 else{
               return Image.network("https://alwaysassure.in/mobile-app/assets/banners/ban3.png",
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height +MediaQuery.of(context).padding.top  );
  }
          //           return _pages[index % _pages.length];
          },
           onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: _pages.length,
          currentPageNotifier: _currentPageNotifier,
          selectedDotColor: Colors.blue,
dotColor: Colors.blueGrey,
        ),
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
              MaterialPageRoute(builder: (context) => Intro2(),));
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

