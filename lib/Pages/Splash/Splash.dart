import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pgu/Pages/Login/Login.dart';
import 'package:pgu/Values/Consts/Consts.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Values/Consts/AppInfo.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Splash extends StatefulWidget {
  @override
  _SplashState createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash> {

  Timer splashDelay;

  @override
  void initState() {
    super.initState();

    splashDelay = Timer(Duration(seconds: Consts.splashDelay), (){
      NoAnimationRoute.open(context, Login());
    });
  }

  @override
  void dispose() {
    splashDelay?.cancel();
    super.dispose();
  }

  void setupValues(BuildContext context){
    SDP.init(context);
    TextSize.build();
  }

  @override
  Widget build(BuildContext context) {
    setupValues(context);

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: PGUColors.background,
        body: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: Image(
                  height: SDP.sdp(100),
                  image: AssetImage('assets/pgu_white.png'),
                )
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                bottom: SDP.sdp(10)
              ),
              child: Text(
                AppInfo.version,
                style: TextStyle(
                    color: PGUColors.text,
                    fontFamily: 'Mont',
                    fontSize: TextSize.small
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async{
    return false;
  }
}
