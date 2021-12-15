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
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwortController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: PGUColors.background,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: SvgPicture.asset(
                  'assets/background.svg',
                  allowDrawingOutsideViewBox: true,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: 50,
                    right: 50
                ),
                child: Container(
                  height:350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30
                        ),
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: PGUColors.background,
                            fontFamily: 'Mont',
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 30,
                              right: 25,
                              left: 25
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color: PGUColors.background,
                                fontFamily: 'Mont'
                            ),
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
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
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 20,
                              right: 25,
                              left: 25
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            autofocus: false,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            style: TextStyle(
                                color: PGUColors.background,
                                fontFamily: 'Mont'
                            ),
                            controller: passwortController,
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
                          )
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: () {
                                //TODO LEHRER
                                if(usernameController.value.text.trim().toMd5() == '2d7a486f1e0c643890f817dd6764bc7b' && passwortController.value.text.trim().toMd5() == '098f6bcd4621d373cade4e832627b4f6'){
                                  StorageManager.setString(StorageKeys.loggedIn, "schueler");
                                  NoAnimationRoute.open(context, Vertretungen());
                                }else{
                                  //TODO show fehlermeldung
                                  closeKeyboard(context);
                                  FlushbarHelper.createError(
                                      message: "Deinen Benutzeraten sind falsch", title: "Fehler : ("
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
                                    fontFamily: 'Mont'
                                ),
                              ),
                            ),
                          ],
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

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async{
    return false;
  }
}
