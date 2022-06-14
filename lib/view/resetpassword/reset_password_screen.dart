import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thoroughio/api/ApiUrl.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/common_widget.dart';
import 'package:thoroughio/utilities/global_utility.dart';

class ResetPasswordScreen extends StatefulWidget {
   ResetPasswordScreen(Map map)
   {
     mapData = map;
   }
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

Map mapData = {};
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpassController = TextEditingController();
bool passwordVisible = true;
bool confirmpasswordVisible = true;


class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
          Center(
              child: Text(
            AppStrings.resetPassword,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height *
                    AppWidgetSize.appTitleFontSize,
                color: AppColor.app_theme_color,
                fontFamily: AppStrings.NotoBold),
          )),

          newPassword(),
          reTypeNewPassword(),

          saveButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          // notGetCodeText()

        ],
      ),
    );
  }

  Widget newPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width *
              AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width *
              AppWidgetSize.app_left_right_padding,
          top: MediaQuery.of(context).size.height *
              AppWidgetSize.app_top_padding),
      width: MediaQuery.of(context).size.width,
      height:
          MediaQuery.of(context).size.height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: passwordController,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        obscureText: passwordVisible,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height *
                AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(context).size.width *
                        AppWidgetSize.appBorderRadius))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(context).size.width *
                        AppWidgetSize.appBorderRadius))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * AppWidgetSize.appBorderRadius))),
            hintText: AppStrings.newPassword,
            hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize, fontFamily: AppStrings.NotoRegular, color: AppColor.hint_text_color)),
      ),
    );
  }

  Widget reTypeNewPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width *
              AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width *
              AppWidgetSize.app_left_right_padding,
          top: MediaQuery.of(context).size.height *
              AppWidgetSize.app_top_padding),
      width: MediaQuery.of(context).size.width,
      height:
          MediaQuery.of(context).size.height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: confirmpassController,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        obscureText: confirmpasswordVisible,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height *
                AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                confirmpasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  confirmpasswordVisible = !confirmpasswordVisible;
                });
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(context).size.width *
                        AppWidgetSize.appBorderRadius))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(context).size.width *
                        AppWidgetSize.appBorderRadius))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.app_gradient_end_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * AppWidgetSize.appBorderRadius))),
            hintText: AppStrings.reTypePassword,
            hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize, fontFamily: AppStrings.NotoRegular, color: AppColor.hint_text_color)),
      ),
    );
  }
  Widget saveButton()
  {
    return InkWell(
      onTap: ()
      {
        if(paswordValidation())
          {
            resetPassword();
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
                  AppColor.app_gradient_start_color
                ]
            )
        ),
        child: Text(
          AppStrings.saveButton,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appHeaderTitleFontSize,
              fontFamily: AppStrings.NotoRegular
          ),
        ),
      ),
    );
  }

  resetPassword() async
  {
    var  checkInternet = await GlobalUtility().isConnected();
    if(checkInternet)
      {
        GlobalUtility().showLoaderDialog(context);

        Map map = {
          "email": mapData["email"],
          "otp" : mapData["otp"].toString(),
          "password":confirmpassController.text.toString()
        };

        String apiResponse = await WebService().send_postrequest_with_map(map);
        debugPrint("${ApiUrl.forgotPassword} ---- ${apiResponse}");

        var jsonData = json.decode(apiResponse);
        var status = jsonData['status'];
        var message = jsonData['message'];
        Navigator.pop(context);

        setState(() {
          if(status == 200)
            {
              GlobalUtility().clearAuthToken();
            }
          else{
            GlobalUtility().showToast(message,context);
          }
        });
      }
    else{
      GlobalUtility().showToast(AppStrings.checkInternet,context);
    }
  }

  bool paswordValidation()
  {
    if(passwordController.text.toString().replaceAll(" ", "")=="")
      {
        GlobalUtility().showToast(AppStrings.passValidate,context);
        return false;
      }
    else if(passwordController.text.toString().length <6)
    {
      GlobalUtility().showToast(AppStrings.passValidate,context);
      return false;
    }
    else if(confirmpassController.text.toString().replaceAll(" ", "")=="")
      {
        GlobalUtility().showToast(AppStrings.confirmpassValidate,context);
        return false;
      }
    else if(confirmpassController.text.toString() != passwordController.text.toString())
      {
        GlobalUtility().showToast(AppStrings.passEqualValidate,context);
        return false;
      }

    return true;
  }

}
