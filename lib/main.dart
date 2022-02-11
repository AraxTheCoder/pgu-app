import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgu/Pages/Splash/Splash.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Consts/AppInfo.dart';
import 'package:pgu/Widgets/Behaviors/DefaultScrollBehavior.dart';

import 'Notifications/PushNotificationService.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const PGUApp());
}

class PGUApp extends StatefulWidget{
  const PGUApp({Key? key}) : super(key: key);

  @override
  _PGUAppState createState() {
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialise();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return _PGUAppState();
  }
}

class _PGUAppState extends State<PGUApp>{
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: PGUColors.transparent,
            statusBarIconBrightness: PGUColors.brightness,
            statusBarBrightness: PGUColors.brightness,
            systemNavigationBarColor: PGUColors.transparent
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppInfo.name,
          home: Splash(),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: DefaultScrollBehavior(),
              child: child!,
            );
          },
        )
    );
  }
}