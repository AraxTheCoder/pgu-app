import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';

import 'flushbar.dart';

class FlushbarHelper{
  /// Get a error notification flushbar
  static Flushbar createError(
      {required String message,
        required String title,
        Duration duration = const Duration(seconds: 3)}) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(
        Icons.warning,
        size: 35,
        color: Colors.red[300],
      ),
      blockBackgroundInteraction: false,//true
      isDismissible: false,
      leftBarIndicatorColor: Colors.red[300],
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.only(
        top: 10
      ),
      messageText: Text(
          message,
        style: TextStyle(
          color: PGUColors.text,
          fontSize: TextSize.medium
        ),
      ),
      padding: EdgeInsets.only(
        left: 30,
        right: 16,
        top: 16,
        bottom: 16
      ),
      titleText: Text(
        title,
        style: TextStyle(
            color: PGUColors.text,
            fontSize: TextSize.medium,
          fontWeight: FontWeight.bold
        ),
      ),
      duration: duration,
    );
  }

  /// Get an information notification flushbar
  static Flushbar createInformation(
      {required String message,
        String? title,
        Duration duration = const Duration(seconds: 3)}) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      leftBarIndicatorColor: Colors.blue[300],
      duration: duration,
      flushbarStyle: FlushbarStyle.GROUNDED,
    );
  }
}