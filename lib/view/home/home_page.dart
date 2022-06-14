import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoroughio/api/ApiUrl.dart';
import 'package:thoroughio/api/WebService.dart';
import 'package:thoroughio/view/login/login_page.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:thoroughio/utilities/global_utility.dart';

import '../../utilities/app_strings.dart';

class HomePage extends StatefulWidget {
  //  HomePage({Key?  key}) : super(key: key);
  String strHoldId="";
  HomePage(String strId){
    strHoldId=strId;
  }

  @override
  _HomePageState createState() => _HomePageState(strHoldId);
}

GlobalKey<ScaffoldState> _scaffoldkeyfinal = new GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  bool isLoading = true;
  bool netConnected = true;
  bool webViewVisibility = true;
  var myWebViewController=null;
  String holdUserId="",strUrl="";
  //LoansInfoResponse  _authenticationResponse;
  _HomePageState(String strHoldId)
  {

    holdUserId=strHoldId;
//    strUrl="https://alwaysassure.in/mobile-app/app_dashboard.php?usid="+holdUserId;
    strUrl="${ApiUrl.homeDashboard}?usid="+holdUserId;
    debugPrint("strUrl="+strUrl);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAuthToken();
    requestPermission();

  }
  Future<void> requestPermission() async {
    // final status = await permission.request();
    final status = await Permission.storage.request();
    setState(() {
      print("Status<><><><>-- $status");
   //   _permissionStatus = status;
      if(status == PermissionStatus.denied) {
        callpermission();
      }
    });
  }

  Future<void> callpermission() async{
    await Permission.storage.request();
  }


/*  getAuthToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     holdUserId= prefs.getString(AppStrings.authToken).toString();
debugPrint("holdUserId=$holdUserId");
   });
    callIsInternetConnected();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkeyfinal,
        body:  Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:  kToolbarHeight/2),

              child: Visibility(
                visible: webViewVisibility,
                child: WebView(
                  //http://alwaysassure.in/mobile-app/app_dashboard.php?usid=78
                  initialUrl:   strUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    myWebViewController = webViewController;
                  },
                  onPageFinished: (finish) {
                    setState(() {
                      debugPrint("loading complete");
                      isLoading = false;
                    });
                  },
                  onWebResourceError: (value) {
                    setState(() {
                      webViewVisibility = false;
                      debugPrint("web view not available");
                    });
                  },
                ),
              ),
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : (!isLoading && netConnected)
                ? Stack()
                : netNotConnected(),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.02 + (kToolbarHeight/2),
                left: MediaQuery.of(context).size.width *0.04,
                right: MediaQuery.of(context).size.width *0.04,
                //  width: MediaQuery.of(context).size.width,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    menubutton(),
                    logoutbutton()
                  ],
                )),


          ],
        )
    );
  }
  Widget netNotConnected() {
    setState(() {
      webViewVisibility = false;
    });

    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 90,
          ),
          Text(
            "ApiUrl.internetNotConnectedPleaseTry",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.039,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.030,
          ),
          retryButton()
        ],
      ),
    );
  }
  Widget retryButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        //Center Column contents horizontally,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width,
            child: RawMaterialButton(
              onPressed: () {
                callIsInternetConnected();
              },
              fillColor: Color(0xffB3C7E6),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Réessayer',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width * 0.039,
                      fontWeight: FontWeight.bold),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
            ),
          )
        ],
      ),
    );
  }

  Widget menubutton()
  {
    return  Center(
      child: InkWell(child: Image.asset(AppStrings.home_header_logo,
        height:MediaQuery.of(context).size.height * 0.05 ,),
        onTap: (){
          //  _scaffoldkeyfinal.currentState!.openDrawer();
        },),
      /* Container(
        width: MediaQuery.of(context).size.width,
        child:
        Image.asset(AppStrings.app_pnglogo,
          height:MediaQuery.of(context).size.height * 0.05 ,),),
*/
    );
  }

  Widget logoutbutton()
  {
    return  InkWell(
        onTap: (){
//
          callLogoutApi();
        }, child: SvgPicture.asset('assets/svgfiles/ic_logout.svg',color:Colors.yellow ,));
  }

  Future<void> callIsInternetConnected() async {
    var chkInternet = await GlobalUtility().isConnected();

    if (chkInternet) {
      setState(() {
        webViewVisibility = true;
        isLoading = true;
        netConnected = true;

        if (myWebViewController != null) {
          myWebViewController
              .loadUrl( strUrl);
        }
        debugPrint("net connected");
      });
    } else {
      setState(() {
        netConnected = false;
        webViewVisibility = false;
        isLoading = false;
        debugPrint("net connected not");
      });
    }
  }
  callLogoutApi() async
  {
    var checkInternet = await GlobalUtility().isConnected();
    if(checkInternet)
    {
      GlobalUtility().showLoaderDialog(context);
      Map map = {
        "action":"logout",
        "user_id":holdUserId
      };

      String apiresponse = await WebService().send_postrequest_with_map(map);
      debugPrint(" -- ${apiresponse}");
      var jsonData = json.decode(apiresponse);
      var status = jsonData['status'];
      var message = jsonData['message'];
      Navigator.pop(context);

      setState(() {
        if(status == true || status == false)
        {
       //   GlobalUtility().clearSharedData();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(),));

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



}
