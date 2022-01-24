import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

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
            closeKeyboard();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              fixedBackground(),
              Container(
                height: 400,
                margin: EdgeInsets.only(
                    left: 35,
                    right: 35
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 30
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: PGUColors.background,
                          fontFamily: 'Mont',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          //top: 20,
                          right: 25,
                          left: 25,
                          bottom: 50
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              maxLines: 1,
                              autofocus: false,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                  color: PGUColors.background,
                                  fontFamily: 'Mont'
                              ),
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: 'Benutzername',
                                labelStyle: TextStyle(
                                    color: PGUColors.background,
                                    fontFamily: 'Mont'
                                ),
                                focusColor: PGUColors.background,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: PGUColors.background,
                                      width: 1.5
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: PGUColors.background,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              maxLines: 1,
                              autofocus: false,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              style: TextStyle(
                                  color: PGUColors.background,
                                  fontFamily: 'Mont'
                              ),
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
                                    color: PGUColors.background,
                                    fontFamily: 'Mont'
                                ),
                                focusColor: PGUColors.background,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(25),
                                // ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: PGUColors.background,
                                      width: 1.5
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: PGUColors.background,
                                      width: 1.5
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                        bottom: 35
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              if(usernameController.value.text.trim().toMd5() == '2d7a486f1e0c643890f817dd6764bc7b' && passwordController.value.text.trim().toMd5() == '098f6bcd4621d373cade4e832627b4f6'){
                                StorageManager.setString(StorageKeys.loggedIn, "s");
                                NoAnimationRoute.open(context, Vertretungen());
                              }else if(usernameController.value.text.trim().toMd5() == '18a90f2c2b4484de555feb4b02904a7a' && passwordController.value.text.trim().toMd5() == '451c683642186ec715fb6574d57b57a2'){
                                StorageManager.setString(StorageKeys.loggedIn, "l");
                                NoAnimationRoute.open(context, Vertretungen());
                              }else{
                                //TODO show fehlermeldung
                                closeKeyboard();
                                FlushbarHelper.createError(
                                    message: "Deinen Benutzerdaten sind falsch", title: "Fehler   : ("
                                )..show(context);
                              }
                            },
                            padding: EdgeInsets.only(
                                left: 25,
                                right: 25,
                                top: 15,
                                bottom: 15
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
                        ],
                      ),
                    )
                  ],
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

  void closeKeyboard(){
    FocusScope.of(context).unfocus();
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async{
    return false;
  }
}
