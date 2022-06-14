import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/apiResponses/RegisterResp.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/global_utility.dart';
import 'package:thoroughio/view/home/home_page.dart';
import 'package:thoroughio/view/home/home_second.dart';
import 'package:thoroughio/view/login/login_page.dart';

import '../../AppFontSize.dart';
import '../../api/ApiUrl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key  key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpassController = TextEditingController();


TextEditingController pinController = TextEditingController();
bool pass_Visible = true;
bool confirmpass_Visible = true;

class _SignUpPageState extends State<SignUpPage> {
  bool view_timer = true;
  var timerStatus = TimerStatus.start;
  bool view_resend_button = false;
  String pinValue = "";

  SharedPreferences prefs;


  @override
  void initState() {
    initialSharedPref();
    super.initState();
  }

  Future<void> initialSharedPref() async {
    prefs  = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white
      , body: ListView(

      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(0, 0,
          0, 0),
      children: [
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.1,),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child:
          Image.asset(AppStrings.logo,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.1,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,),),
        Center(child: Text(AppStrings.signUp, style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appTitleFontSize,
            color: AppColor.app_theme_color,
            fontFamily: AppStrings.NotoBold
        ),)),
   //     userName(),
        mobileNumber(),
     //   emailaddress(),
      //  password(),
       // confirmpassword(),
        signup_button(),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.03,),
        bottomText(),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.02,),


      ],
    ),
    );
  }


  Widget userName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: MediaQuery
          .of(context)
          .size
          .width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding,
          top: MediaQuery
              .of(context)
              .size
              .height * AppWidgetSize.app_top_padding),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: usernameController,
        maxLines: 1,
        minLines: 1,
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(
                Icons.person_outline_sharp,
                color: Colors.black38,
              ),
              onPressed: () {

              },
            ),
            contentPadding: EdgeInsets.fromLTRB(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Name',
            hintStyle: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color: AppColor.hint_text_color
            )

        ),

      ),

    );
  }

  Widget mobileNumber() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: MediaQuery
          .of(context)
          .size
          .width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding,
          top: MediaQuery
              .of(context)
              .size
              .height * AppWidgetSize.app_top_padding),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: phoneController,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(
                Icons.phone,
                color: Colors.black38,
              ),
              onPressed: () {

              },
            ),
            contentPadding: EdgeInsets.fromLTRB(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Mobile Number',
            hintStyle: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color: AppColor.hint_text_color
            )

        ),

      ),

    );
  }

  Widget emailaddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: MediaQuery
          .of(context)
          .size
          .width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding,
          top: MediaQuery
              .of(context)
              .size
              .height * AppWidgetSize.app_top_padding),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: emailController,
        maxLines: 1,
        minLines: 1,
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(
                Icons.alternate_email_sharp,
                color: Colors.black38,
              ),
              onPressed: () {

              },
            ),
            contentPadding: EdgeInsets.fromLTRB(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Email Address',
            hintStyle: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color: AppColor.hint_text_color
            )

        ),

      ),

    );
  }

  Widget password() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.01,
          left: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: passwordController,
        maxLines: 1,
        minLines: 1,
        textAlign: TextAlign.left,
        obscureText: pass_Visible,
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                pass_Visible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  pass_Visible = !pass_Visible;
                });
              },
            ),
            prefixIcon: IconButton(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.black38,
              ),
              onPressed: () {

              },
            ),
            contentPadding: EdgeInsets.fromLTRB(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Enter Password',
            hintStyle: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color: AppColor.hint_text_color
            )
        ),
      ),
    );
  }


  Widget confirmpassword() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.01,
          left: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_left_right_padding),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * AppWidgetSize.app_textfeild_size,
      child: TextField(
        // expands: true,
        controller: confirmpassController,
        maxLines: 1,
        minLines: 1,
        obscureText: confirmpass_Visible,
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                confirmpass_Visible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  confirmpass_Visible = !confirmpass_Visible;
                });
              },
            ),
            prefixIcon: IconButton(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.black38,
              ),
              onPressed: () {

              },
            ),
            contentPadding: EdgeInsets.fromLTRB(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.app_theme_color, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * AppWidgetSize.appBorderRadius))
            ),
            hintText: 'Re Password',
            hintStyle: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * AppWidgetSize.appContentTitleFontSize,
                fontFamily: AppStrings.NotoRegular,
                color: AppColor.hint_text_color
            )

        ),

      ),

    );
  }


  Widget signup_button() {
    return InkWell(
      onTap: () {
        if (validate()) {
          signuApi();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery
            .of(context)
            .size
            .height * AppWidgetSize.appButtonSize,
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.03,
            left: MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_left_right_padding,
            right: MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_left_right_padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.appBorderRadius),

            ),
            color: AppColor.button_color
        ),
        child: Text(
          'Submit',
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * AppWidgetSize.appHeaderTitleFontSize,
              fontFamily: AppStrings.NotoRegular
          ),
        ),
      ),
    );
  }

  Widget bottomText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppStrings.NotoRegular,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * AppWidgetSize.appContentTitleFontSize
          ),
          children: <TextSpan>[
            TextSpan(text: 'Sign In',
                style: TextStyle(fontFamily: AppStrings.NotoRegular,
                    color: AppColor.app_theme_color,
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * AppWidgetSize.appContentTitleFontSize,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),));
                  }),
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(),));
            }
      ),
    );
  }


  bool validate() {
   /* if (usernameController.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.userNameValidate, context);
      return false;
    }
    else*/ if (phoneController.text.toString().replaceAll(" ", "") == "" ||
        phoneController.text.length != 10) {
      GlobalUtility().showToast(AppStrings.phoneValidate, context);
      return false;
    }
/*
    else if (emailController.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.emailValidate, context);
      return false;
    }

    else if (!GlobalUtility().validateEmail(emailController.text.toString())) {
      GlobalUtility().showToast(AppStrings.emailValidate, context);
      return false;
    }
    else if (passwordController.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.passValidate, context);
      return false;
    }
    else if (passwordController.text
        .toString()
        .length < 6) {
      GlobalUtility().showToast(AppStrings.passValidate, context);
      return false;
    }
    else if (confirmpassController.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.confirmpassValidate, context);
      return false;
    }
    else if (confirmpassController.text != passwordController.text) {
      GlobalUtility().showToast(AppStrings.passEqualValidate, context);
      return false;
    }
*/
    return true;
  }


  signuApi() async
  {
    var check_internet = await GlobalUtility().isConnected();
    if (check_internet) {
      Map map = {
       /* "action": "signup_user",
        "email": emailController.text.toString(),
        "name": usernameController.text.toString(),
        "phone": phoneController.text.toString(),
        "password": confirmpassController.text.toString(),
        "devicetoken": "device_token",
        "version": "1.0",
        "reg_via": "app",
        "ref_by": "",
        "devicetype": Platform.isAndroid ? "android" : "ios",*/
        "action":"signup_user",
        "phone":phoneController.text.toString(),
        "devicetype":"android",
        "devicetoken":"egeghhghhh567",
        "version":"1.0"


      };
      GlobalUtility().showLoaderDialog(context);
      String apiResponse = await WebService().send_postrequest_with_map(map);

      var jsondata = json.decode(apiResponse);
      bool status = jsondata['status'];
      String message = jsondata['message'];

      Navigator.pop(context);
      if (status == true) {
        GlobalUtility().showToast(message, context);
            RegisterResp                _authenticationResponse = RegisterResp.fromJson(jsondata);
        showOtpDialog(_authenticationResponse.data[0].otp_code.toString(),_authenticationResponse.data[0].us_phone.toString());

/*
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(_authenticationResponse.data[0].id.toString())),
        );
*/
      }
      else {
        GlobalUtility().showToast(message, context);
      }
    }
    else {
      GlobalUtility().showToast(AppStrings.checkInternet, context);
    }
  }




   showOtpDialog(String strOTP, String strPhn)  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(20.0),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[

                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              child: Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                          )),


                      Text('Confirm Verification Code', style:
                      TextStyle(color: Colors.black,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * AppFontSize.appContentSmallFontSize),
                      ),

                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02,),

                      otpfields(),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                     /*     Visibility(
                            visible: view_timer,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.25,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * AppFontSize.appButtonHeight,
                              child: SimpleTimer(
                                duration: Duration(seconds: 120),
                                status: timerStatus,
                                // onStart: handleTimerOnStart,
                                timerStyle: TimerStyle.ring,
                                onEnd: () {
                                  setState(() {
                                    view_resend_button = true;
                                    view_timer = false;
                                  });
                                },
                                backgroundColor: Colors.transparent,
                                //  valueListener: timerValueChangeListener,
                                progressIndicatorColor: Colors.transparent,
                                progressIndicatorDirection: TimerProgressIndicatorDirection
                                    .clockwise,
                                progressTextCountDirection: TimerProgressTextCountDirection
                                    .count_down,
                                progressTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      AppFontSize
                                          .appContentFontSize, *//* fontFamily: AppFontFamily.DMSANS_REGULAR*//*),
                                strokeWidth: 1,
                              ),
                            ),
                          ),

                          Visibility(
                            visible: view_resend_button,
                            child: TextButton(
                              onPressed: () {
                                //sendOtpApi("reset");
                                setState(() {
                                  timerStatus = TimerStatus.start;
                                  view_resend_button = false;
                                  view_timer = true;
                                  pinController.clear();
                                });
                              },
                              child: Text('Re-send', style: TextStyle(
                                color: Colors.yellow,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    AppFontSize.appContentSmallFontSize,
                              ),
                              ),
                            ),
                          ),*/
SizedBox(),
                          GestureDetector(
                            onTap: () {
                              print(
                                  "yes clicked $strOTP    pincontroller=${pinValue}");

                              if (strOTP.toString() == pinValue.toString()) {
                                print(" $strOTP matched");
                                callVerifyOTP(pinValue,strPhn);
                              }
                              else {
                                GlobalUtility().showToast(
                                    "OTP not matched", context);
                              }
                             },
                            child: Container(
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                              alignment: Alignment.center,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.25,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * AppFontSize.appButtonHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        AppFontSize.appButtonBorderRadius)),
                                gradient: LinearGradient(
                                    colors:
                                    [
                                      /*AppColors.appFirstGradientColor*/
                                      Colors.cyan,
                                      Colors.cyan,

                                    ],
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                    tileMode: TileMode.repeated),

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: /*AppColors.appButtonTextColor*/Colors
                                          .white,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          AppFontSize.appContentFontSize,

                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      //  Text('Would you like to approve of this message?'),
                    ],
                  ),
                ),

              );
            }

        );
      },
    );
  }


  callVerifyOTP(String pinValue, String strPhn) async {

    var checkInternet = await GlobalUtility().isConnected();
    if (checkInternet) {
      GlobalUtility().showLoaderDialog(context);
      Map map = {
        "action": "signup_user_otp_verify",
        "phone": strPhn,
        "otp_code": pinValue

              };

      String apiresponse = await WebService().send_postrequest_with_map(map);
      debugPrint("userlogin_otp -- ${apiresponse}");
      var jsonData = json.decode(apiresponse);
      var status = jsonData['status'];
      var message = jsonData['message'];

      Navigator.pop(context);

      setState(() {
        if (status == true) {
          GlobalUtility().showToast(message, context);
          int userId = jsonData['user_id'];

          prefs.setString(AppStrings.authToken, ""+userId.toString());

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => /*HomePage*/HomeSecond(userId.toString() + ""),)
          );
        }
        else {
          GlobalUtility().showToast(message, context);
        }
      });
    }
    else {
      GlobalUtility().showToast(AppStrings.checkInternet, context);
    }
  }
  Widget otpfields() {
    return TextField(
      controller: pinController,
      maxLines: 1,
      minLines: 1,
      style: TextStyle(
          fontSize: MediaQuery
              .of(context)
              .size
              .height * AppWidgetSize.appContentTitleFontSize,
          fontFamily: AppStrings.NotoRegular,
          color: Colors.black
      ),

      onChanged: (text) {
        setState(() {
          pinValue = text.toString();
        });
      },

    );
  }

  }