import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Pages/Classes/Classes.dart';
import 'package:pgu/Pages/Introduction/Introduction.dart';
import 'package:pgu/Pages/Login/Login.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageManager.dart';
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

  Timer? splashDelay;

  @override
  void initState() {
    super.initState();

    StorageManager.init();

    splashDelay = Timer(Duration(seconds: Consts.splashDelay), (){
      NoAnimationRoute.open(context, Vertretungen());
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
            SvgPicture.asset(
              'assets/background.svg',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.cover,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  bottom: SDP.sdp(100)
                ),
                child: SvgPicture.asset(
                  'assets/pgu.svg',
                  height: SDP.sdp(100),
                ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                bottom: SDP.sdp(20)
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
