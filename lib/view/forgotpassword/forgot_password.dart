import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thoroughio/api/ApiUrl.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/common_widget.dart';
import 'package:thoroughio/utilities/global_utility.dart';
import 'package:thoroughio/view/login/verify_otp_page.dart';
import 'package:thoroughio/view/resetpassword/reset_password_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

TextEditingController emailcontroller= TextEditingController();
class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          Stack(
            children: [
              CommonWidget(true, false,""),
              Positioned(
                top: MediaQuery.of(context).size.height * AppWidgetSize.icon_margin_top + kToolbarHeight,
                left: 0,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColor.app_theme_color,
                  ),
                ),
              ),
            ],
          ),

          Center(child: Text(AppStrings.forgotPassword,style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appTitleFontSize,
              color: AppColor.app_theme_color,
              fontFamily:AppStrings.NotoBold
          ),)),
          emailaddress(),
          continueButton(),

        ],
      ),
    );
  }
  Widget  emailaddress()
  {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          top: MediaQuery.of(context).size.height * AppWidgetSize.app_top_padding),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: emailcontroller,
        maxLines: 1,
        minLines: 1,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color:Colors.black
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:AppColor.app_gradient_end_color,width: 1 ),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color:AppColor.app_gradient_end_color,width: 1 ),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color:AppColor.app_gradient_end_color,width: 1 ),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Email Address',
            hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color:AppColor.hint_text_color
            )

        ),

      ),
    );
  }
  Widget continueButton()
  {
    return InkWell(
      onTap: ()
      {
        if(validate())
          {
            sendOtp(emailcontroller.text.toString());
          }
      },
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * AppWidgetSize.appButtonSize,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
            right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *AppWidgetSize.appBorderRadius)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                colors: [
                  AppColor.app_theme_color,
                  AppColor.app_theme_color
                ]
            )
        ),
        child: Text(
          AppStrings.continueButton,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appHeaderTitleFontSize,
              fontFamily: AppStrings.NotoRegular
          ),
        ),
      ),
    );
  }

  bool validate()
  {
    if(emailcontroller.text.toString().replaceAll(" ", "")=="")
      {
        GlobalUtility().showToast(AppStrings.emailValidate,context);
        return false;
      }
    else if(!GlobalUtility().validateEmail(emailcontroller.text.toString())){
      GlobalUtility().showToast(AppStrings.emailValidate,context);
      return false;
    }
    return true;
  }


  sendOtp( String email) async
  {
    var check_internet = await GlobalUtility().isConnected();
    if(check_internet)
    {
      Map map = {
        "email": emailcontroller.text.toString(),
        "for":"forget"
      };
      GlobalUtility().showLoaderDialog(context);
      String apiResponse = await WebService().send_postrequest_with_map(map);
       var jsondata = json.decode(apiResponse);
      int status = jsondata['status'];
      String message = jsondata['message'];
      var otp = jsondata['otp'];

      Navigator.pop(context);
      if(status == 200)
      {
        GlobalUtility().showToast(message,context);
        Map map = {
          'otp':otp
        };

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VerifyOtpPage("forget",
                emailcontroller.text.toString(),map))
        );

      }
      else if(status == 400)
      {
        GlobalUtility().showToast(message,context);
      }
    }
  }
}
