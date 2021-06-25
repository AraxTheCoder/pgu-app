import 'package:flutter/material.dart';
import 'package:pgu/Pages/Plans/Plans.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/CredentialUtils.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Input/Button/RoundOutlinedButton.dart';
import 'package:pgu/Widgets/Input/Text/RoundFilledInput.dart';
import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Login extends StatefulWidget {
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController passwort = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadCredentials();
  }

  void loadCredentials() async{
    await StorageManager.init();
    setState(() {
      username.text = CredentialUtils.getUsername();
      passwort.text = CredentialUtils.getPassword();
      //print("Password: " + passwort.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    //loadCredentials();
    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          //resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: PGUColors.background,
          body: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: SDP.sdp(150)),
                child: Image(
                  height: SDP.sdp(100),
                  image: AssetImage('assets/pgu_white.png'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: SDP.sdp(300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: PGUColors.text,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SDP.sdp(40)),
                        topRight: Radius.circular(SDP.sdp(40)),
                        bottomLeft: Radius.circular(SDP.sdp(25)),
                        bottomRight: Radius.circular(SDP.sdp(25)),
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: SDP.sdp(15)),
                        child: Text(
                          "Einloggen",
                          style: TextStyle(
                              color: PGUColors.background,
                              fontFamily: 'Mont',
                              fontSize: TextSize.big),
                        ),
                      ),
                      Container(
                        width: SDP.sdp(100),
                        child: Divider(
                          color: PGUColors.background,
                          thickness: SDP.sdp(1.5),
                        ),
                      ),
                      RoundFilledInput("Benutzername", username,
                          paddingTop: SDP.sdp(20),
                          hintSize: TextSize.small,
                          height: SDP.sdp(35),
                          radius: SDP.sdp(12.5),
                          inputAction: TextInputAction.next),
                      RoundFilledInput(
                        "Passwort",
                        passwort,
                        paddingTop: SDP.sdp(10),
                        hintSize: TextSize.small,
                        height: SDP.sdp(35),
                        radius: SDP.sdp(12.5),
                        obscureText: true,
                        inputAction: TextInputAction.done,
                      ),
                      RoundOutlinedButton(
                        "Login",
                        PGUColors.text,
                        textColor: PGUColors.background,
                        paddingTop: SDP.sdp(30),
                        fontSize: TextSize.medium,
                        height: SDP.sdp(35),
                        onClick: openPlans,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String schuelerPasswordHash = "098f6bcd4621d373cade4e832627b4f6";
  String lehrerPasswordHash = "451c683642186ec715fb6574d57b57a2";

  void openPlans() {
    if (username.value.text.toLowerCase() == "schueler" && CredentialUtils.generateMd5(passwort.value.text) == schuelerPasswordHash) {
      StorageManager.setString(StorageKeys.username, username.value.text);
      StorageManager.setString(StorageKeys.password, passwort.value.text);
      NoAnimationRoute.open(context, Plans());
    } else {
      FlushbarHelper.createError(
          title: "Falsche Zugangsdaten", message: "Die Zugangsdaten bekommst\ndu bei deinem Lehrer")
        ..show(context);
    }
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
