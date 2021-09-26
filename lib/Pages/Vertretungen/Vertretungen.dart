import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Models/Vertretung.dart';
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

    loadCachedVertretungen();
    loadClasses();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    if (jsonString.isNotEmpty) {
      classes = List<ClassCode>.from(
          json.decode(jsonString).map((model) => ClassCode.fromJson(model)));
    }

    loadVertretungen();
  }

  Dio dio = new Dio();

  void loadCachedVertretungen(){
    String jsonString = StorageManager.getString(StorageKeys.vertretungen);

    if (jsonString.isNotEmpty) {
      entities = List<Vertretung>.from(
          json.decode(jsonString).map((model) => Vertretung.fromJson(model)));
      setState(() {

      });
    }
  }

  void loadVertretungen() async {
    for(ClassCode classCode in classes){
      Response response = await dio.get("https://pgu.backslash-vr.com/api/user/get" + "?code=" + classCode.code!);

      if(response.statusCode == 200){
        // print(response.data.toString());

        entities = List<Vertretung>.from(
            json.decode(response.data.toString()).map((model) => Vertretung.fromJson(model)));

        // print(entities.length);

        StorageManager.setString(StorageKeys.vertretungen, jsonEncode(entities));

        setState(() {

        });
      }
    }
  }

  List<ClassCode> classes = [];

  List<Vertretung> entities = [];

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
                      child: entities.isEmpty ? Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: SDP.sdp(110)
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/dog_small_nb_cropped.png'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Text(
                                      "Keine\nVertretungen",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: TextSize.big,
                                        fontFamily: 'Mont',
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 5
                                          ..color = PGUColors.background,
                                      ),
                                    ),
                                    Text(
                                      "Keine\nVertretungen",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: PGUColors.text,
                                        fontSize: TextSize.big,
                                        fontFamily: 'Mont',
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(10.0, 10.0),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          Shadow(
                                            offset: Offset(10.0, 10.0),
                                            blurRadius: 8.0,
                                            color: Color.fromARGB(125, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) : Padding(
                        padding: EdgeInsets.only(top: SDP.sdp(30)),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            children: vertretungenItems(),
                          ),
                        ),
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

  List<Widget> vertretungenItems() {
    List<Widget> vertretungenItems = [];

    int itemHeight = 20;

    for (int a = 0; a < min(entities.length, (SDP.height - 450) / itemHeight); a++) {
      vertretungenItems.add(Vertretung.item(entities[a]));
    }

    return vertretungenItems;
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
