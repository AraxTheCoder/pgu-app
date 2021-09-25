import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Pages/Settings/Settings.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Classes extends StatefulWidget {
  bool forced = false;

  Classes(this.forced);

  @override
  _ClassesState createState() {
    return _ClassesState();
  }
}

class _ClassesState extends State<Classes> {
  @override
  void initState() {
    super.initState();

    loadClasses();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    if (jsonString.isNotEmpty) {
      entities = List<ClassCode>.from(
          json.decode(jsonString).map((model) => ClassCode.fromJson(model)));
    }
  }

  List<ClassCode> entities = [];

  @override
  Widget build(BuildContext context) {
    // loadClasses();

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  top: SDP.safepaddingtop + SDP.sdp(30),
                  bottom: SDP.sdp(0),
                  left: SDP.sdp(25),
                  right: SDP.sdp(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Deine\n",
                        style: TextStyle(
                            fontFamily: 'Mont-normal',
                            fontSize: 18,
                            color: PGUColors.background),
                        children: [
                          TextSpan(
                              text: "Klassen",
                              style:
                                  TextStyle(fontFamily: 'Mont', fontSize: 32))
                        ]),
                  ),
                  Expanded(
                      child: entities.isEmpty ? Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SDP.sdp(110)
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/dog_small_nb_cropped.png'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Text(
                                      "Keine Klassen",
                                      style: TextStyle(
                                        fontSize: TextSize.big,
                                        fontFamily: 'Mont',
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 5
                                          ..color = PGUColors.background,
                                      ),
                                    ),
                                    Text(
                                      "Keine Klassen",
                                      style: TextStyle(
                                        color: PGUColors.text,
                                        fontSize: TextSize.big,
                                        fontFamily: 'Mont',
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(10.0, 10.0),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          Shadow(
                                            offset: Offset(10.0, 10.0),
                                            blurRadius: 8.0,
                                            color: Color.fromARGB(125, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) : Padding(
                        padding: EdgeInsets.only(top: SDP.sdp(30)),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            children: classItems(),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(bottom: SDP.sdp(110), right: SDP.sdp(25)),
              child: GestureDetector(
                onTap: addClicked,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: -pi / 4,
                      child: Container(
                        height: SDP.sdp(50),
                        width: SDP.sdp(50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SvgPicture.asset(
                            'assets/background.svg',
                            allowDrawingOutsideViewBox: false,
                            fit: BoxFit.cover,
                          ),
                          // child: Container(
                          //   color: PGUColors.background,
                          // )
                        ),
                      ),
                    ),
                    Icon(
                      Icons.add_rounded,
                      color: PGUColors.text,
                      size: SDP.sdp(35),
                    )
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    bottom: SDP.sdp(25), right: SDP.sdp(20), left: SDP.sdp(20)),
                child: Container(
                  width: double.infinity,
                  height: SDP.sdp(60),
                  decoration: BoxDecoration(
                    color: PGUColors.background,
                    borderRadius: BorderRadius.circular(SDP.sdp(27)),
                    border: Border.all(width: 0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.person_rounded, //person_outline_rounded
                          color: PGUColors.text,
                          size: SDP.sdp(20),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.home_outlined,
                          color: PGUColors.text,
                          size: SDP.sdp(20),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: openSettings,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.settings_outlined,
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void openSettings(){
    NoAnimationRoute.open(context, Settings());
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  void addClicked() {
    TextEditingController codeController = new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return WillPopScope(
                onWillPop: () async {
                  closeKeyboard(context);

                  return false;
                },
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 6,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20
                          ),
                          child: Text(
                            "Klasse hinzufügen",
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
                                top: 25,
                                right: 25,
                                left: 25
                            ),
                            child: TextFormField(
                              maxLines: 1,
                              autofocus: false,
                              maxLength: 8,
                              // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              controller: codeController,
                              onChanged: (value) {
                                setState((){

                                });
                              },
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                  color: PGUColors.background,
                                  fontFamily: 'Mont'
                              ),
                              decoration: InputDecoration(
                                labelText: 'Code',
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
                            )),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                padding: EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    top: 15,
                                    bottom: 15
                                ),
                                // color: PGUColors.accent,
                                child: Text(
                                  "Abbrechen",
                                  style: TextStyle(
                                      color: PGUColors.background,
                                      fontFamily: 'Mont'
                                  ),
                                ),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  validateCode(codeController.text, context);
                                },
                                padding: EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    top: 15,
                                    bottom: 15
                                ),
                                color: codeController.text.length < 8 ? PGUColors.red : PGUColors.accent,
                                child: Text(
                                  "Hinzufügen",
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
                ),
              );
            },
          );
        });
  }

  Dio dio = new Dio();

  void validateCode(String code, BuildContext context) async {
    if(code.length == 8){
      closeKeyboard(context);

      Response response = await dio.get("https://pgu.backslash-vr.com/api/user/authorize" + "?code=" + code);

      if(response.statusCode == 200){
        print(response.data.toString());

        ClassCode classCode = new ClassCode.fromJson(jsonDecode(response.data.toString()));

        if(entities.indexWhere((element) => element.code == classCode.code) == -1)
          entities.add(classCode);

        print(entities.length);

        StorageManager.setString(StorageKeys.classes, jsonEncode(entities));

        Navigator.of(context).pop();

        setState(() {

        });
      }
    }
  }

  List<Widget> classItems() {
    List<Widget> classItems = [];

    for (int a = 0; a < entities.length; a++) {
      classItems.add(ClassCode.item(entities[a], deleteClass));
    }

    return classItems;
  }

  void deleteClass(ClassCode classCode){
    print("Called");
    entities.remove(classCode);
    StorageManager.setString(StorageKeys.classes, jsonEncode(entities));

    setState(() {

    });
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
