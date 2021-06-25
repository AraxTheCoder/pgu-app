import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgu/Pages/Splash/Splash.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Consts/AppInfo.dart';
import 'package:pgu/Widgets/Behaviors/DefaultScrollBehavior.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

void main() {
  runApp(PGUApp());
}

class PGUApp extends StatefulWidget{
  @override
  _PGUAppState createState() {
    return _PGUAppState();
  }
}

class _PGUAppState extends State<PGUApp>{
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: PGUColors.background,
            statusBarIconBrightness: PGUColors.brightness,
            systemNavigationBarColor: PGUColors.background
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppInfo.name,
          home: Splash(),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: DefaultScrollBehavior(),
              child: child,
            );
          },
        )
    );
  }
}