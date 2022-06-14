import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thoroughio/utilities/app_strings.dart';

import 'app_color.dart';
import 'app_widgetsize.dart';

class CommonWidget extends StatelessWidget {
   CommonWidget(bool is_image, bool is_text,String title)
   {
     isImage = is_image;
     isText = is_text;
     header_title = title;
   }
   bool  isImage=false;
   bool  isText=false;
   String header_title="" ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      //  Image.asset(AppStrings.app_header,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),

      SizedBox(height:MediaQuery.of(context).size.height * 0.1 + kToolbarHeight ,),
        // SvgPicture.asset(AppStrings.app_header,fit: BoxFit.cover,
        // width: MediaQuery.of(context).size.width,),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.01 + kToolbarHeight,
          left: 0,
          right: 0,
          child:  isImage== true ? Container(
            width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(AppStrings.app_logo,width: MediaQuery.of(context).size.width* 0.1,
                height:MediaQuery.of(context).size.height * 0.09 ,),) : isText == true ?

          Center(
            child: Text(header_title,
            style: TextStyle(
              color: AppColor.app_theme_color,
              fontFamily: AppStrings.NotoBold,
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appLargeTitleFontSize,
            ),),)
              :
          SizedBox(),
        )

      ],
    );
  }
}
