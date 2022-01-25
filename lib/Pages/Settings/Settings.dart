import 'package:flutter/material.dart';
import 'package:pgu/Pages/Classes/Classes.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  // SizedBox(height: 30,),
                  // Text("Benachrichtigungen",
                  //   style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                  // SizedBox(height: 10,),
                  // Text("Noch nicht ",
                  //   style: TextStyle(fontFamily: 'Mont-normal', fontSize: 17),),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 110
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     // SizedBox(height: 30,),
                      //     // Text("Tutorial",
                      //     //   style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                      //     // SizedBox(height: 10,),
                      //     // GestureDetector(
                      //     //   onTap: (){
                      //     //
                      //     //   },
                      //     //   child: Text("Tutorial ansehen",
                      //     //     style: TextStyle(fontFamily: 'Mont-normal', fontSize: 17, color: PGUColors.blue),),
                      //     // ),
                      //     SizedBox(height: 30,),
                      //     Text("Benachrichtigungen",
                      //       style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                      //     SizedBox(height: 10,),
                      //     Text("Kommen noch",
                      //       style: TextStyle(fontFamily: 'Mont-normal', fontSize: 17),),
                      //     SizedBox(height: 30,),
                      //     Text("Kontakt",
                      //       style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                      //     SizedBox(height: 10,),
                      //     Text("Bei Fehlern oder Wünschen:\nkrueger.jonathan@gmx.de",
                      //       style: TextStyle(fontFamily: 'Mont-normal', fontSize: 17),),
                      //     SizedBox(height: 30,),
                      //     Text("Source Code",
                      //       style: TextStyle(fontFamily: 'Mont', fontSize: 25),),
                      //     SizedBox(height: 10,),
                      //     Text("github.com/AraxTheCoder/pgu-app",
                      //       style: TextStyle(fontFamily: 'Mont-normal', fontSize: 17),),
                      //   ],
                      // ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Text("Source Code",
                                style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await launch("https://github.com/AraxTheCoder/pgu-app");
                                },
                                child: Container(
                                  color: PGUColors.transparent,
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "github.com/AraxTheCoder/pgu-app",
                                    style: TextStyle(
                                        fontFamily: 'Mont-normal', fontSize: 15,
                                        color: PGUColors.blue
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text("Kontakt",
                                style:
                                TextStyle(fontFamily: 'Mont', fontSize: 20),
                              ),
                              Text("Bei Fehlern oder Wünschen",
                                style:
                                TextStyle(fontFamily: 'Mont', fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await launch("mailto:krueger.jonathan@gmx.de?subject=PGU%20App%20Fehler%20oder%20Wunsch");
                                },
                                child: Container(
                                  color: PGUColors.transparent,
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "krueger.jonathan@gmx.de",
                                    style: TextStyle(
                                        fontFamily: 'Mont-normal', fontSize: 15,
                                        color: PGUColors.blue
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/baustelle_cropped.png'),
                                    Text(
                                      "Baustelle",
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
                                      "Baustelle",
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    bottom: SDP.sdp(25), right: 25, left: 25),
                child: Container(
                  width: double.infinity,
                  height: 78.5,
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
                              size: 25,
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
                              size: 25,
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
                            size: 25,
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
