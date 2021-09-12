import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Timer? splashDelay;

  @override
  void initState() {
    super.initState();

    splashDelay = Timer(Duration(seconds: 3), (){
      print("timer");
      // NoAnimationRoute.open(context, Main());
    });
  }

  @override
  void dispose() {
    splashDelay?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: content()
        ),
      ),
    );
  }

  Widget content(){
    return Container();
  }

  Future<bool> onBackPressed() async{
    return false;
  }
}
