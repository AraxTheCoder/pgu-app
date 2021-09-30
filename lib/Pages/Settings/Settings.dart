import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Pages/Classes/Classes.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
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

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
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
                              text: "Einstellungen",
                              style:
                              TextStyle(fontFamily: 'Mont', fontSize: 32))
                        ]),
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          Text("Credits",
                          style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                          SizedBox(height: 20,),
                          RichText(
                            text: TextSpan(
                                text: "Krüger\n",
                                style: TextStyle(
                                    fontFamily: 'Mont-normal',
                                    fontSize: 12,
                                    color: PGUColors.background),
                                children: [
                                  TextSpan(
                                      text: "Jonathan\n",
                                      style:
                                      TextStyle(fontFamily: 'Mont', fontSize: 22),
                                  ),
                                  TextSpan(
                                    text: '"I see no other God then me up here"',
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(height: 20,),
                          RichText(
                            text: TextSpan(
                                text: "Helas\n",
                                style: TextStyle(
                                    fontFamily: 'Mont-normal',
                                    fontSize: 12,
                                    color: PGUColors.background),
                                children: [
                                  TextSpan(
                                    text: "Tristan\n",
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 22),
                                  ),
                                  TextSpan(
                                    text: 'pablo. (@tristan.hlx)',
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 14),
                                  )
                                ]),
                          ),
                          SizedBox(height: 20,),
                          RichText(
                            text: TextSpan(
                                text: "Benecke\n",
                                style: TextStyle(
                                    fontFamily: 'Mont-normal',
                                    fontSize: 12,
                                    color: PGUColors.background),
                                children: [
                                  TextSpan(
                                    text: "Karl\n",
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 22),
                                  ),
                                  TextSpan(
                                    text: "It's hard being a single mother, especially when you have no children and are a teenage male.",
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 14),
                                  )
                                ]),
                          ),
                        ],
                      )
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
                        child: GestureDetector(
                          onTap: openVertretungen,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.home_outlined, //person_outline_rounded
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.settings_rounded,
                            color: PGUColors.text,
                            size: SDP.sdp(20),
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

  void openVertretungen(){
    NoAnimationRoute.open(context, Vertretungen());
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
