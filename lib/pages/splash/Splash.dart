import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Pages/Home/Home.dart';
import 'package:pgu/Pages/Login/Login.dart';
import 'package:pgu/Pages/Tutorial/Tutorial.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Consts/Consts.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Dio dio = Dio();
  Timer? splashDelay;

  @override
  void initState() {
    super.initState();

    asnycInit();
  }

  //TODO: Refactoring
  void asnycInit() async{
    await StorageManager.init();

    checkTokenUpdate();

    splashDelay = Timer(const Duration(seconds: Consts.splashDelay), (){
      if(StorageManager.getString(StorageKeys.loggedIn) == "") {
        NoAnimationRoute.push(context, const Login());
      }else if(StorageManager.isEmpty(StorageKeys.tutorialWatched)) {
        NoAnimationRoute.push(context, const Tutorial());
      }else{
        NoAnimationRoute.push(context, const Home());
      }
    });
  }

  Future<void> checkTokenUpdate() async {
    //await StorageManager.init();

    String oldToken = StorageManager.getString(StorageKeys.token);
    String? token = await FirebaseMessaging.instance.getToken();

    if(oldToken != token){
      //Update Token to Server
      try{
        Response response = await dio.get("https://pgu.backslash-vr.com/api/notifications/update?oldToken=" + oldToken + "&token=" + token!);

        if(response.statusCode == 200 && response.data == "Updated"){
          //Save Token
          StorageManager.setString(StorageKeys.token, token);
        }
      }catch (SocketException){
        print("[Splash] offline");
      }
    }
  }

  @override
  void dispose() {
    splashDelay?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/background.svg',
          allowDrawingOutsideViewBox: true,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              bottom: 100,
          ),
          child: SvgPicture.asset(
            'assets/pgu.svg',
            height: 175,
          ),
        ),
      ],
    );
  }
}
