import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgu/Pages/Splash/Splash.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Consts/AppInfo.dart';

import 'Notifications/PushNotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(PGUApp());
}

class PGUApp extends StatefulWidget{
  PGUApp({Key? key}) : super(key: key){
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialise();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  _PGUAppState createState() => _PGUAppState();
}

class _PGUAppState extends State<PGUApp>{
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: PGUColors.transparent,
            systemNavigationBarColor: PGUColors.transparent,
        ),
        child: WillPopScope(
          onWillPop: popHandler,
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppInfo.name,
            home: Splash(),
          ),
        )
    );
  }

  //Dont Pop Base Route -> Don't leave the App
  Future<bool> popHandler() async{
    return false;
  }
}