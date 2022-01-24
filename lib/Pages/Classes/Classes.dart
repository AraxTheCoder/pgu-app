import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Formatter/UpperCaseTextFormatter.dart';
import 'package:pgu/Models/ClassModel.dart';
import 'package:pgu/Models/ClassModel.dart';
import 'package:pgu/Pages/Settings/Settings.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/Keyboard.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
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
  final TextEditingController nameController = new TextEditingController();
  @override
  void initState() {
    super.initState();

    loadClasses();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    if (jsonString.isNotEmpty) {
      entities = List<ClassModel>.from(
          json.decode(jsonString).map((model) => ClassModel.fromJson(model)));
    }
  }

  List<ClassModel> entities = [];

  @override
  Widget build(BuildContext context) {
    loadClasses();

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
                        height: 75,
                        width: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SvgPicture.asset(
                            'assets/background.svg',
                            allowDrawingOutsideViewBox: false,
                            fit: BoxFit.cover,
                          ),
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
                        child: GestureDetector(
                          onTap: openVertretungen,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.home_outlined,
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
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

  void openVertretungen(){
    NoAnimationRoute.open(context, Vertretungen());
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  void addClicked() {
    int state = 0;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return WillPopScope(
                onWillPop: () async {
                  if(state == 1) {
                    closeKeyboard(context);
                    state = 0;
                    return false;
                  }

                  return true;
                },
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 6,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                          ),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Klasse hinzufügen",
                            style: TextStyle(
                              color: PGUColors.background,
                              fontFamily: 'Mont',
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                //top: 25,
                                right: 25,
                                left: 25
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              maxLines: 1,
                              autofocus: false,
                              maxLength: 2,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.deny(" ")
                              ],
                              // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              controller: nameController,
                              onTap: (){
                                state = 1;
                              },
                              onEditingComplete: (){
                                state = 0;
                                Keyboard.close(context);
                              },
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
                                fillColor: PGUColors.inputBackground,
                                filled: true,
                                hintText: "Klasse",
                                prefix: SizedBox(width: 15,),
                                hintStyle: TextStyle(
                                    color: PGUColors.inactive,
                                    fontFamily: 'Mont'
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none
                                ),
                              ),
                            )
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(
                            bottom: 25
                          ),
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
                                  //validateCode(codeController.text, context);
                                  closeKeyboard(context);

                                  addClass(nameController.text.toUpperCase());
                                },
                                padding: EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    top: 15,
                                    bottom: 15
                                ),
                                color: nameController.text.length < 2 ? PGUColors.red : PGUColors.accent,
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

  void addClass(String className){
    if(className.length < 2) {
      Keyboard.close(context);
      FlushbarHelper.createError(
          message: "So sieht eine Klasse aus: 8b", title: "Zu kurz   : ("
      )..show(context);
      return;
    }

    ClassModel classModel = new ClassModel(className);

    if(!classModel.name!.isValidClassname())
      return;

    if(entities.indexWhere((element) => element.name == classModel.name) == -1)
      entities.add(classModel);

    print("[Classes] Number of Classes: " + entities.length.toString());

    StorageManager.setString(StorageKeys.classes, jsonEncode(entities));

    Navigator.of(context).pop();

    nameController.clear();

    setState(()=>null);
  }

  Dio dio = new Dio();

  List<Widget> classItems() {
    List<Widget> classItems = [];

    for (int a = 0; a < entities.length; a++) {
      classItems.add(ClassModel.item(entities[a], deleteClass));
    }

    return classItems;
  }

  void deleteClass(ClassModel classCode){
    print("[Classes] Delete " + classCode.name!);
    entities.remove(classCode);
    StorageManager.setString(StorageKeys.classes, jsonEncode(entities));

    setState(()=>null);
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
