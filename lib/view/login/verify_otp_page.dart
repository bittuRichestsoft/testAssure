import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:thoroughio/api/ApiUrl.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/apiResponses/AuthenticationResponse.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';
import 'package:thoroughio/utilities/common_widget.dart';
import 'package:thoroughio/utilities/global_utility.dart';
import 'package:thoroughio/view/home/home_page.dart';
import 'package:thoroughio/view/home/home_second.dart';
import 'package:thoroughio/view/login/login_page.dart';
import 'package:thoroughio/view/resetpassword/reset_password_screen.dart';

class VerifyOtpPage extends StatefulWidget {
 VerifyOtpPage(String from, String Email,Map map)
 {
   coming_from = from;
   email = Email;
   mapdata = map;
   debugPrint("map data ${mapdata.toString()}");
 }
 @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

String coming_from ="";
var timerStatus = TimerStatus.start;
bool view_resend_text = false;
bool view_timer = true;
String email="";
Map  mapdata;
var  otp;
var enteredOtp ="";
AuthenticationResponse  _authenticationResponse;

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          CommonWidget(true,false,""),

          // title
          Center(child: Text("Verify Account",style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appTitleFontSize,
              color: AppColor.app_theme_color,
              fontFamily:AppStrings.NotoBold
          ),)),

          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          otpfields(),
          continue_button(),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          otptimer(),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          resendText(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

        ],
      ),
    );
  }




  Widget otptimer()
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: SimpleTimer(
        duration:  Duration(seconds: AppStrings.TIME_IN_SEONDS),
        status: timerStatus,
        onEnd: (){
          setState(() {
            view_resend_text = true;
            view_timer = false;
          });
        },
        backgroundColor: Colors.transparent,
        //  valueListener: timerValueChangeListener,
        progressIndicatorColor: Colors.transparent,
        progressTextStyle: TextStyle(color: Colors.black,
            fontSize: MediaQuery.of(context).size.height *
                AppWidgetSize.appContentTitleFontSize, fontFamily:AppStrings.NotoSemiBold),
        strokeWidth: 1,
      ),
    );

  }



  Widget otpfields()
  {
    return PinCodeTextField(
   textStyle: TextStyle(color: Colors.white,
   fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize),
      appContext: context,
      enablePinAutofill: false,
      length: 4,
      autoDisposeControllers: true,
      obscureText: false,
      validator: (v) {
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.03)),
         fieldHeight: MediaQuery.of(context).size.height * 0.085,
        fieldWidth: MediaQuery.of(context).size.width * 0.17,
        errorBorderColor: AppColor.app_theme_color,
        borderWidth: 1,
         inactiveColor: AppColor.app_theme_color,
         inactiveFillColor: Colors.transparent,
         selectedColor:AppColor.app_theme_color ,
         activeFillColor: AppColor.app_theme_color,
         activeColor: AppColor.app_theme_color,
         selectedFillColor: AppColor.app_theme_color,
         disabledColor: AppColor.app_theme_color,
         fieldOuterPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03,
             right:MediaQuery.of(context).size.width * 0.03,top: MediaQuery.of(context).size.height * 0.01,bottom:MediaQuery.of(context).size.height * 0.01 ),
      ),
      cursorColor: Colors.white,
      autoFocus: false,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: (pin) {
         setState(() {
             enteredOtp = pin;
         });
      },
      onChanged: (pin){
        setState(() {
          enteredOtp = pin;
        });
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }


  Widget continue_button()
  {
    return InkWell(
      onTap: ()
      {
       navigateToNext();

      },
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * AppWidgetSize.appButtonSize,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,
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
          'Continue',
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appHeaderTitleFontSize,
              fontFamily: AppStrings.NotoRegular
          ),
        ),
      ),
    );
  }



  Widget resendText()
  {
    return InkWell(
      onTap: (){
        sendOtp(email);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Didn\'t get code? ',
            style:TextStyle(
                fontFamily: AppStrings.NotoRegular,
                color:view_resend_text == true? Colors.black:Colors.black12,
                fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize
            ),
            children:<TextSpan>[
              TextSpan(text: 'Resend Code', style: TextStyle(fontFamily: AppStrings.NotoRegular,
                  color: view_resend_text==true? AppColor.app_gradient_end_color :Colors.black12,
                  fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize,
                  decoration: TextDecoration.underline)),
            ],
            recognizer: TapGestureRecognizer()..onTap=(){
            setState(() {
              timerStatus = TimerStatus.start;
              view_resend_text = false;
             });
            }
        ),
      ),
    );
  }




  registerUser()async
  {
    var checkInterntet = await GlobalUtility().isConnected();
    if(checkInterntet)
      {
        GlobalUtility().showLoaderDialog(context);
        Map map = {
          "email":email,
          "password":mapdata['password'],
          "device_token":mapdata['device_token'],
          "device_type":mapdata['device_type'],
          "device_name":mapdata['device_name'],
          "otp":mapdata['otp'].toString()
        };

        String apiResponse = await WebService().send_postrequest_with_map(map );
        debugPrint("${ApiUrl.register} --- ${apiResponse}");
        var jsonData = json.decode(apiResponse);
        var status = jsonData['status'];
        var message = jsonData['message'];
        Navigator.pop(context);

        setState(() {
          if(status == 200)
            {
               GlobalUtility().showToast(message,context);
               _authenticationResponse = authenticationResponseFromJson(apiResponse);
               GlobalUtility().setData(_authenticationResponse.data.token.toString());
               if(coming_from == "signup")
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),)
                );
              }
              else{
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => /*HomePage*/HomeSecond(""+_authenticationResponse.data.token.toString()),)
                );
              }
            }
          else {
            GlobalUtility().showToast(message,context);
          }
        });
      }
    else{
      GlobalUtility().showToast(AppStrings.checkInternet,context);
    }
  }



  navigateToNext()
  {
    debugPrint("${coming_from}");
    // in case coming from signup
    if(coming_from == "signup")
    {
      if(enteredOtp != mapdata['otp'].toString())
      {
        debugPrint("${coming_from} 1 ${enteredOtp}");
        GlobalUtility().showToast(AppStrings.otpValidate,context);
      }
      else if(enteredOtp == "")
      {
        debugPrint("${coming_from} 12 ${enteredOtp}");
        GlobalUtility().showToast(AppStrings.otpValidate,context);
      }
      else{
        registerUser();
      }
    }

    //in case coming from forgot password
    else if(coming_from == "forget")
      {
        if(enteredOtp != mapdata['otp'].toString())
        {
          debugPrint("${coming_from} 1 ${enteredOtp}  --mapdata ${ mapdata['otp']}");
          GlobalUtility().showToast(AppStrings.otpValidate,context);
        }
        else if(enteredOtp== "")
        {
          debugPrint("${coming_from} 12 ${enteredOtp}");
          GlobalUtility().showToast(AppStrings.otpValidate,context);
        }

        else{
          Map forgotMap = {
            "otp":mapdata['otp'],
            "email":email
          };
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetPasswordScreen(forgotMap),)
          );
        }
      }

  }

  sendOtp( String email) async
  {
    var check_internet = await GlobalUtility().isConnected();
    if(check_internet)
    {
      Map map = {
        "email": email,
        "for":coming_from
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
        mapdata['otp'] = otp;
      }
      else if(status == 400)
      {
        GlobalUtility().showToast(message,context);
      }
    }
    else{
      GlobalUtility().showToast(AppStrings.checkInternet,context);
    }
  }

}
