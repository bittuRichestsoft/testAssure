import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:thoroughio/api/ApiUrl.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/apiResponses/LoginResp.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/global_utility.dart';
import 'package:thoroughio/view/forgotpassword/forgot_password.dart';
import 'package:thoroughio/view/home/home_page.dart';
import 'package:thoroughio/view/home/home_second.dart';
import 'package:thoroughio/view/register/signup.dart';

import '../../AppFontSize.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key  key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController email_controller = TextEditingController();
TextEditingController password_controller = TextEditingController();
bool _passwordIconVisible = true;
LoansInfoResponse  _authenticationResponse;
class _LoginPageState extends State<LoginPage> {
  var timerStatus = TimerStatus.start;
  TextEditingController pinController = TextEditingController();
  String pinValue = "";
  SharedPreferences prefs;

  bool view_resend_button = false;
  bool view_timer = true;

  @override
  void initState() {
    initialSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.1,),
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
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                children: [
                  Center(child: Text(AppStrings.login, style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * AppWidgetSize.appTitleFontSize,
                      color: AppColor.app_theme_color,
                      fontFamily: AppStrings.NotoBold
                  ),)),
                  emailaddress(),
                  //   passowrd(),
                  //     forgetPsd(),
                  login_button(),
                  //   Align(alignment: Alignment.centerRight, child: forgotpassowrd()),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  bottomText(),
                ],
              ),
            ),
          )
        ],
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
        controller: email_controller,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.appContentTitleFontSize,
            fontFamily: AppStrings.NotoRegular,
            color: Colors.black
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(MediaQuery
              .of(context)
              .size
              .width * AppWidgetSize.app_textfeild_padding, 0, 0, 0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.app_theme_color, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * AppWidgetSize.appBorderRadius))
          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.app_theme_color, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * AppWidgetSize.appBorderRadius))
          ),

          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.app_theme_color, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * AppWidgetSize.appBorderRadius))
          ),

          hintText: AppStrings.enter_email_mobile,
          hintStyle: TextStyle(
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * AppWidgetSize.appContentTitleFontSize,
              fontFamily: AppStrings.NotoRegular,
              color: AppColor.hint_text_color
          ),

          prefixIcon: IconButton(
            icon: Icon(
              Icons.person_outline_sharp,
              color: Colors.black38,
            ),
            onPressed: () {
              setState(() {
                _passwordIconVisible = !_passwordIconVisible;
              });
            },
          ),
        ),

      ),
    );
  }

  Widget forgotpassowrd() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword(),)
          );
        },
        child: Text(
          AppStrings.forgotPassword + "?",
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppStrings.NotoRegular,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * AppWidgetSize.appContentTitleFontSize
          ),)
    );
  }

  Widget passowrd() {
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
        controller: password_controller,
        obscureText: _passwordIconVisible,
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
                Icons.lock_outline_sharp,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  _passwordIconVisible = !_passwordIconVisible;
                });
              },
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordIconVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black38,
              ),
              onPressed: () {
                setState(() {
                  _passwordIconVisible = !_passwordIconVisible;
                });
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
            hintText: AppStrings.password,
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

  Widget login_button() {
    return InkWell(
      onTap: () {
        debugPrint("email ${email_controller.text}");
        if (loginDataValidate()) {
          loginUser();
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
                .width * AppWidgetSize.appBorderRadius)),
            color: AppColor.button_color
        ),
        child: Text(
          AppStrings.submit,
          style: TextStyle(
              color: AppColor.white,
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

  forgetPsd() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery
                .of(context)
                .size
                .width * AppWidgetSize.app_left_right_padding,
            top: MediaQuery
                .of(context)
                .size
                .height * AppWidgetSize.app_top_padding),

        child: InkWell(child: Text("Forget Password?"),
          onTap: () {

            /*Map mapData = {};
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ResetPasswordScreen(mapData),)
          );*/

          },
        ),
      ),
    );
  }

  Widget bottomText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: AppStrings.dont_have_account,
          style: TextStyle(
              fontFamily: AppStrings.NotoRegular,
              color: Colors.black,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * AppWidgetSize.appContentTitleFontSize
          ),
          children: <TextSpan>[
            TextSpan(text: AppStrings.signUp,
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
                        MaterialPageRoute(builder: (context) => SignUpPage(),)
                    );
                  }),
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage(),)
              );
            }
      ),
    );
  }

  bool loginDataValidate() {
    if (email_controller.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.enter_email_mobile, context);
      return false;
    }
    /*else if(!GlobalUtility().isNumeric(email_controller.text.toString()) && !GlobalUtility().validateEmail(email_controller.text.toString())){
      GlobalUtility().showToast(AppStrings.emailValidate,context);
      return false;
    }*/
/*
    else if (password_controller.text.toString().replaceAll(" ", "") == "") {
      GlobalUtility().showToast(AppStrings.passValidate, context);
      return false;
    }
*/
    return true;
  }


  loginUser() async
  {
    var checkInternet = await GlobalUtility().isConnected();
    if (checkInternet) {
      GlobalUtility().showLoaderDialog(context);
      Map map = {
        "action": "userlogin",
        "phone": email_controller.text.toString(),
      };

      String apiresponse = await WebService().send_postrequest_with_map(map);
      debugPrint("userlogin -- ${apiresponse}");
      var jsonData = json.decode(apiresponse);
      var status = jsonData['status'];
      var message = jsonData['message'];
      Navigator.pop(context);
      setState(() {
        if (status == true) {
          GlobalUtility().showToast(message, context);
          _authenticationResponse = loansInfoResponseFromJson(apiresponse);
          showOtpDialog(_authenticationResponse.otp.toString());
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

  showOtpDialog(String otp) {
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

                        /*  Visibility(
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
                                  "yes clicked $otp    pincontroller=${pinController
                                      .text}");

                              if (otp.toString() == pinValue.toString()) {
                                print(" $otp matched");
                                callVerifyOTP(pinValue);
                              }
                              else {
                                GlobalUtility().showToast(
                                    "OTP not matched", context);
                              }
                              //   (!view_resend_button)?loginApi(): GlobalUtility().showToast("Otp expire please resend otp");
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
                                    tileMode: TileMode.repeated)

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: /*AppColors.appButtonTextColor*/Colors
                                          .tealAccent,
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


  callVerifyOTP(String pinValue) async {

    var checkInternet = await GlobalUtility().isConnected();
    if (checkInternet) {
      GlobalUtility().showLoaderDialog(context);
      Map map = {
        "action": "userlogin_otp",
        "phone": email_controller.text.toString(),
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
          String userId = jsonData['user_id'];

          prefs.setString(AppStrings.authToken, ""+userId);

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


  Future<void> initialSharedPref() async {
  prefs  = await SharedPreferences.getInstance();
  }


}