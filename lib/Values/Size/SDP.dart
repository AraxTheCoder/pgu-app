import 'package:flutter/material.dart';

class SDP{
  static int? dimen;
  static double width = 0, height = 0;
  static BuildContext? context;
  static late double safepaddingtop;

  static void init(BuildContext context){
    SDP.context = context;
    safepaddingtop = MediaQuery.of(context).padding.top;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    for(int di = 300; di <= 800; di = di +30){
      if(width > di) {
        dimen = di;
      }
    }
  }

  static double sdp(double dp) {
    return (dp / 300) * width;
  }
}