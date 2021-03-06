import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  //final FirebaseMessaging _fcm;

  //PushNotificationService(this._fcm);

  Future initialise() async {
    // if (Platform.isIOS) {
    //   _fcm.requestNotificationPermissions(IosNotificationSettings());
    // }

    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    String? token = await FirebaseMessaging.instance.getToken();
    print("FirebaseMessaging token: $token");

    FirebaseMessaging.onMessage.listen((message) {
      print("onMessage: " + message.notification!.title!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("onLaunch: $message");
    });

    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
  }
}