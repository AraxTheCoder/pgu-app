import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Classes extends StatefulWidget {
  bool forced = false;

  Classes(this.forced);

  @override
  _ClassesState createState() {
    return _ClassesState();
  }
}

class _ClassesState extends State<Classes> {

  @override
  void initState() {
    super.initState();
  }

  List<ClassCode> entities = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        //resizeToAvoidBottomPadding: true,
        // resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  top: SDP.safepaddingtop + SDP.sdp(30),
                  bottom: SDP.sdp(0),
                  left: SDP.sdp(25),
                  right: SDP.sdp(25)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Deine\n",
                        style: TextStyle(
                            fontFamily: 'Mont-normal',
                            fontSize: 18,
                            color: PGUColors.background
                        ),
                        children: [
                          TextSpan(
                              text: "Klassen",
                              style: TextStyle(
                                  fontFamily: 'Mont',
                                  fontSize: 32
                              )
                          )
                        ]
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: SDP.sdp(30)
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child:  ListView(
                          children: classItems(),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(
                  bottom: SDP.sdp(110),
                  right: SDP.sdp(25)
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 4,
                    child: Container(
                      height: SDP.sdp(50),
                      width: SDP.sdp(50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: SvgPicture.asset(
                          'assets/background.svg',
                          allowDrawingOutsideViewBox: false,
                          fit: BoxFit.cover,
                        ),
                        // child: Container(
                        //   color: PGUColors.background,
                        // )
                      ),
                    ),
                  ),
                  Icon(
                    Icons.add_rounded,
                    color: PGUColors.text,
                    size: SDP.sdp(35),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  bottom: SDP.sdp(25),
                  right: SDP.sdp(20),
                  left: SDP.sdp(20)
              ),
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
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: PGUColors.text,
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.home_outlined,
                        color: PGUColors.text,
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.settings_outlined,
                        color: PGUColors.text,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> classItems(){
    List<Widget> classItems = [];

    entities.clear();
    for(int a = 0; a < 3; a++){
      entities.add(new ClassCode("Q2", "34XH%F"));
    }

    for(int a = 0; a < entities.length; a++){
      classItems.add(ClassCodeItem(entities[a]));
    }

    return classItems;
  }

  Widget ClassCodeItem(ClassCode classCode){
    return Container(
      width: double.infinity,
      height: SDP.sdp(60),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        bottom: SDP.sdp(10)
      ),
      padding: EdgeInsets.only(
        left: SDP.sdp(20)
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: PGUColors.background.withOpacity(0.075)
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Klasse/Stufe\n",
                style: TextStyle(
                    fontFamily: 'Mont-normal',
                    fontSize: 12,
                    color: PGUColors.background
                ),
                children: [
                  TextSpan(
                      text: classCode.name,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 25
                      )
                  )
                ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: SDP.sdp(20)
            ),
            child: RichText(
              text: TextSpan(
                  text: "Code\n",
                  style: TextStyle(
                      fontFamily: 'Mont-normal',
                      fontSize: 12,
                      color: PGUColors.background
                  ),
                  children: [
                    TextSpan(
                        text: classCode.code,
                        style: TextStyle(
                            fontFamily: 'Mont',
                            fontSize: 25
                        )
                    )
                  ]
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  right: SDP.sdp(20)
              ),
              child: Icon(
                Icons.delete_rounded,
                color: PGUColors.red,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
