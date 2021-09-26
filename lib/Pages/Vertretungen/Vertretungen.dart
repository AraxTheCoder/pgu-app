import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Pages/Classes/Classes.dart';
import 'package:pgu/Pages/Settings/Settings.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Vertretungen extends StatefulWidget {
  @override
  _VertretungenState createState() {
    return _VertretungenState();
  }
}

class _VertretungenState extends State<Vertretungen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  top: SDP.safepaddingtop + SDP.sdp(30),
                  bottom: SDP.sdp(0),
                  left: SDP.sdp(25),
                  right: SDP.sdp(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Deine\n",
                        style: TextStyle(
                            fontFamily: 'Mont-normal',
                            fontSize: 18,
                            color: PGUColors.background),
                        children: [
                          TextSpan(
                              text: "Vertretungen",
                              style:
                              TextStyle(fontFamily: 'Mont', fontSize: 32))
                        ]),
                  ),
                  Expanded(
                      child: Container()
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    bottom: SDP.sdp(25), right: SDP.sdp(20), left: SDP.sdp(20)),
                child: Container(
                  width: double.infinity,
                  height: SDP.sdp(60),
                  decoration: BoxDecoration(
                    color: PGUColors.background,
                    borderRadius: BorderRadius.circular(SDP.sdp(27)),
                    border: Border.all(width: 0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: openClasses,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.person_outline_rounded, //person_outline_rounded
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.home_rounded,
                          color: PGUColors.text,
                          size: SDP.sdp(20),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: openSettings,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.settings_outlined, //person_outline_rounded
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void openClasses(){
    NoAnimationRoute.open(context, Classes(false));
  }

  void openSettings(){
    NoAnimationRoute.open(context, Settings());
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
