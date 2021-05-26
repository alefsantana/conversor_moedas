
import 'package:flutter/cupertino.dart';

import 'app_bar_widget.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
    preferredSize: Size.fromHeight(200),
    child: Container(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 161,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: double.maxFinite,
            decoration: BoxDecoration(gradient: AppGradients.linear),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  height: 240,
                 width: 240,
                  decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(300),
                shape: BoxShape.circle,

                ),
                  child: Center(
                    child: Image.asset ("assets/image/real.png"),
                  ),
                ),
              ],
            ),

          ),

          Align(
            alignment: Alignment(0.0 , 1.0),


          )
        ],
      ),
    ),
  );
}
