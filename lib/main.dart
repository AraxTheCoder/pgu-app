import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'behaviors/DefaultBehavior.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          //statusBarIconBrightness: AppTheme.getOpposite(),
          //systemNavigationBarColor: AppTheme.background
        ),
        child: materialApp()
    );
    //return materialApp();
  }

  Widget materialApp(){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // navigatorKey: navigatorKey,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: DefaultBehavior(),
          child: child,
        );
      },
    );
  }
}
