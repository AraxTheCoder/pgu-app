import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() {
    return _IntroductionState();
  }
}

class _IntroductionState extends State<Introduction> {

  @override
  void initState() {
    super.initState();
  }

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
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(
                bottom: SDP.sdp(35),
                right: SDP.sdp(25)
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 4,
                    child: Container(
                      height: SDP.sdp(55),
                      width: SDP.sdp(55),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        // child: SvgPicture.asset(
                        //   'assets/background.svg',
                        //   allowDrawingOutsideViewBox: false,
                        //   fit: BoxFit.cover,
                        // ),
                        child: Container(
                          color: PGUColors.background,
                        )
                      ),
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    color: PGUColors.text,
                    size: SDP.sdp(40),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                top: SDP.safepaddingtop + SDP.sdp(35),
                left: SDP.sdp(25)
              ),
              child: RichText(
                text: TextSpan(
                  text: "Willkommen in der\n",
                  style: TextStyle(
                      fontFamily: 'Mont-normal',
                    fontSize: 18,
                    color: PGUColors.background
                  ),
                  children: [
                    TextSpan(
                        text: "PGU\nVertretungsplan\nApp",
                      style: TextStyle(
                        fontFamily: 'Mont',
                        fontSize: 32
                      )
                    )
                  ]
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Im folgenden "
              ),
            )
          ],
        ),
      ),
    );
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
