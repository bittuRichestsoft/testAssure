import 'package:flutter/material.dart';

import 'app_color.dart';

class CommonTimeline extends StatelessWidget {
   CommonTimeline(int step_number,bool is_completed)
   {
     step = step_number;
     isCompleted = is_completed;
   }
   bool isCompleted = true;
   int step=1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
/*        // step1
        FloatingActionButton.small(
          backgroundColor: step==1 || step==2 || isCompleted
              ? AppColor.app_theme_color
              : AppColor.app_gradient_start_color,
          onPressed: () {},
          child: const Text("1"),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width / 3.2,
          child: LinearProgressIndicator(
            backgroundColor: AppColor.app_gradient_end_color,
            valueColor: AlwaysStoppedAnimation(AppColor.app_theme_color),
            value: step==1 || step==2 ||isCompleted ?100:0,
          ),
        ),

        // step 2
        FloatingActionButton.small(
            backgroundColor: step==2 || step==3
                ? AppColor.app_theme_color
                : AppColor.app_gradient_start_color,
            onPressed: null,
            child: Text("2")),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.8,
          child: LinearProgressIndicator(
            backgroundColor: AppColor.app_gradient_start_color,
            valueColor: AlwaysStoppedAnimation(AppColor.app_theme_color),
            value:  step == 3 && isCompleted== true ? 100 : 0,
          ),
        ),

        // step 3
        FloatingActionButton.small(
            backgroundColor: step == 3 && isCompleted== true
                ? AppColor.app_theme_color
                : AppColor.app_gradient_start_color,
            onPressed: null,
            child: Text("3")),*/
      ],
    );
  }
}
