import 'package:flutter/material.dart';
import 'package:thoroughio/utilities/app_color.dart';
import 'package:thoroughio/utilities/app_strings.dart';
import 'package:thoroughio/utilities/app_widgetsize.dart';

class MultiselectDropdown extends StatefulWidget {
  const MultiselectDropdown({Key key}) : super(key: key);

  @override
  _MultiselectDropdownState createState() => _MultiselectDropdownState();
}
var days_list = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8'
];
var selected_day;
String text;
List<String> multipleSelectValues = [];
TextEditingController textEditingController = TextEditingController();
List<String> titleList = ['1','2','3','4','5'];
List<bool> checkList = [false,false,false,false,false];
String value="";

class _MultiselectDropdownState extends State<MultiselectDropdown> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          right: MediaQuery.of(context).size.width * AppWidgetSize.app_left_right_padding,
          top: MediaQuery.of(context).size.height * 0.1),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height * AppWidgetSize.app_dropdowm_size,
          child: InkWell(
            onTap: (){
              showmyDialog();
            },
            child: TextField(
        controller: textEditingController,
        enabled: false,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.text,
        style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize,
              fontFamily: AppStrings.NotoRegular,
              color:Colors.black
        ),
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_outlined
          ),
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

              hintText: "Select",
              hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * AppWidgetSize.appContentTitleFontSize,
                  fontFamily: AppStrings.NotoRegular,
                  color:AppColor.hint_text_color
              )
        ),

      ),
          )
    )
    );
  }


  // String showValue()
  // {
  //
  //   print("");
  //   if(multipleSelectValues.length == 1)
  //     {
  //      text = multipleSelectValues[0];
  //      value= text!;
  //     }
  //   else{
  //     for(int i=0 ; i< multipleSelectValues.length-1;i++)
  //       {
  //         //for(int j = i+1;j<multipleSelectValues.length;j++){
  //           text = multipleSelectValues[i] +","+multipleSelectValues[i+1];
  //         //}
  //       }
  //     value = text!;
  //   }
  //   return value!;
  // }


  Future<void> showmyDialog() async
  {
    showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *
                  AppWidgetSize.appBorderRadius))
          ),

          child: Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: titleList.length,
                itemBuilder: (context,index){
                  return CheckboxListTile(
                    title: Text(titleList[index]),
                      value: checkList[index],
                      onChanged: (value){
                        setState(() {
                            multipleSelectValues.add(titleList[index]);
                            checkList[index] = value;
                            textEditingController.text = multipleSelectValues.join(",");
                        });
                      });
                }),),),
      );
    });

  }

}
