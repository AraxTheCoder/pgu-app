import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/Keyboard.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Widgets/Input/OnelineInput.dart';
import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
import 'package:pgu/Widgets/Output/flushbar.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*

  Design Reference:
  https://cdn.dribbble.com/users/2597347/screenshots/9513237/start-ui_-_copy_4x.png

 */

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: PGUColors.background,
        body: GestureDetector(
          onTap: (){
            Keyboard.close(context);
          },
          child: Stack(
            children: [
              fixedBackground(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(50),
                        topRight:  Radius.circular(50)
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            right: 40,
                            left: 40,
                        ),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 40,
                                  bottom: 40,
                              ),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: PGUColors.background,
                                  fontFamily: 'Mont',
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            OnelineInput(usernameController, "Benutzername", Icons.person_rounded),
                            SizedBox(
                              height: 20,
                            ),
                            OnelineInput(passwordController, "Passwort", Icons.vpn_key_rounded)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(
                            bottom: 35
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {
                            if(usernameController.value.text.trim().toMd5() == '2d7a486f1e0c643890f817dd6764bc7b' && passwordController.value.text.trim().toMd5() == '098f6bcd4621d373cade4e832627b4f6'){
                              StorageManager.setString(StorageKeys.loggedIn, "s");
                              NoAnimationRoute.open(context, Vertretungen());
                            }else if(usernameController.value.text.trim().toMd5() == '18a90f2c2b4484de555feb4b02904a7a' && passwordController.value.text.trim().toMd5() == '451c683642186ec715fb6574d57b57a2'){
                              StorageManager.setString(StorageKeys.loggedIn, "l");
                              NoAnimationRoute.open(context, Vertretungen());
                            }else{
                              Keyboard.close(context);
                              FlushbarHelper.createError(
                                message: "Deinen Benutzerdaten sind falsch", title: "Fehler   : (",
                                position: FlushbarPosition.TOP
                              )..show(context);
                            }
                          },
                          padding: EdgeInsets.only(
                              left: 35,
                              right: 35,
                              top: 17.5,
                              bottom: 17.5
                          ),
                          color: PGUColors.accent,
                          child: Text(
                            "Einloggen",
                            style: TextStyle(
                                color: PGUColors.text,
                                fontFamily: 'Mont',
                                fontSize: 17.5
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fixedBackground(){
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SvgPicture.asset(
        'assets/background.svg',
        allowDrawingOutsideViewBox: true,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async{
    return false;
  }
}
