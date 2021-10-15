import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Models/ClassCode.dart';
import 'package:pgu/Models/Vertretung.dart';
import 'package:pgu/Pages/Classes/Classes.dart';
import 'package:pgu/Pages/Settings/Settings.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/ColorChooser.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Vertretungen extends StatefulWidget {
  @override
  _VertretungenState createState() {
    return _VertretungenState();
  }
}

class _VertretungenState extends State<Vertretungen> {
  @override
  void initState() {
    super.initState();

    loadClasses();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    if (jsonString.isNotEmpty) {
      classes = List<ClassCode>.from(
          json.decode(jsonString).map((model) => ClassCode.fromJson(model)));

      if(classes.isNotEmpty)
        loadCachedVertretungen();
    }

    loadVertretungen();
  }

  Dio dio = new Dio();

  void loadCachedVertretungen(){
    String jsonString = StorageManager.getString(StorageKeys.vertretungen);

    if (jsonString.isNotEmpty) {
      cachedEntities = List<Vertretung>.from(
          json.decode(jsonString).map((model) => Vertretung.fromJson(model)));
    }

    setState(() {

    });
  }

  void loadVertretungen() async {
    entities = [];
    bool classnameChange = false;
    for(int a = 0; a < classes.length; a++){
      ClassCode classCode = classes[a];

      Response response = await dio.get("https://pgu.backslash-vr.com/api/user/get" + "?code=" + classCode.code!);

      if(response.statusCode == 200){

        entities += List<Vertretung>.from(
            json.decode(response.data.toString()).map((model) => Vertretung.fromJson(model)));

        if(entities.length >= 1 && classCode.name != entities[entities.length - 1].klasse){
          classes[a].name = entities[entities.length - 1].klasse;
          classnameChange = true;
        }
      }
    }

    if(classnameChange) {
      StorageManager.setString(StorageKeys.classes, jsonEncode(classes));
      StorageManager.setString(StorageKeys.ausgeblendeteKurse, jsonEncode([]));
    }

    StorageManager.setString(StorageKeys.vertretungen, jsonEncode(entities));

    if(mounted){
      setState(() {

      });
    }
  }

  List<ClassCode> classes = [];

  List<Vertretung> entities = [];
  List<Vertretung> cachedEntities = [];

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Widget> items = vertretungenItems();

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
                  //left: SDP.sdp(25),
                  //right: SDP.sdp(25)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SDP.sdp(25),
                      right: SDP.sdp(25)
                    ),
                    child: RichText(
                      text: TextSpan(
                          text: "Deine\n",
                          style: TextStyle(
                              fontFamily: 'Mont-normal',
                              fontSize: 18,
                              color: PGUColors.background),
                          children: [
                            TextSpan(
                                text: "Vertretungen",
                                style:
                                TextStyle(fontFamily: 'Mont', fontSize: 32))
                          ]),
                    ),
                  ),
                  Expanded(
                      child: (entities.isNotEmpty ? entities.isEmpty : cachedEntities.isEmpty) ? Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: SDP.sdp(110),
                            left: SDP.sdp(25),
                            right: SDP.sdp(25)
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
                                      "Keine\nVertretungen",
                                      textAlign: TextAlign.center,
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
                                      "Keine\nVertretungen",
                                      textAlign: TextAlign.center,
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
                      ) :
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 130,
                        ),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                                stops: [0.0, 0.05, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return items[index];
                              },
                            ),
                          ),
                        ),
                      )
                  )
                ],
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
                        child: GestureDetector(
                          onTap: openClasses,
                          child: Container(
                            color: PGUColors.debug ? PGUColors.red : PGUColors.transparent,
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.person_outline_rounded, //person_outline_rounded
                              color: PGUColors.text,
                              size: SDP.sdp(20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.home_rounded,
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
                              Icons.settings_outlined, //person_outline_rounded
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

  List<Widget> vertretungenItems() {
    List<Widget> vertretungenItems = [];

    List<String>? ausgeblendeteKurse;

    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty)
      ausgeblendeteKurse = [];
    else
      ausgeblendeteKurse = List<String>.from(jsonDecode(jsonString));

    vertretungenItems.add(SizedBox(height: 15,));

    for (int a = 0; a < (entities.isNotEmpty ? entities.length : cachedEntities.length); a++) {
      Vertretung v = entities.isNotEmpty ? entities[a] : cachedEntities[a];

      if(!ausgeblendeteKurse.contains(v.klasse! + "|" + v.kurs!))
        vertretungenItems.add(Vertretung.item(v, context, refresh));
    }

    vertretungenItems.add(
      GestureDetector(
        onTap: showAusgeblendeteKurse,
        child: Container(
          //color: Colors.red,
          padding: EdgeInsets.only(
              top: 20,
              bottom: 30
          ),
          child: Text(
            "Ausgeblendete Kurse anzeigen",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Mont'
            ),
          ),
        ),
      )
    );

    vertretungenItems.add(SizedBox(height: 15,));

    return vertretungenItems;
  }

  void showAusgeblendeteKurse(){
    List<String>? ausgeblendeteKurse;

    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty)
      ausgeblendeteKurse = [];
    else
      ausgeblendeteKurse = List<String>.from(jsonDecode(jsonString));

    changed = Map<String, bool>();

    for(String s in ausgeblendeteKurse){
      changed![s] = false;
    }

    showDialog(
        context: context,
        builder: (b){
          return StatefulBuilder(
            builder: (c, setState){
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 6,
                backgroundColor: Colors.transparent,
                child: Container(
                  //height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20
                        ),
                        child: Text(
                          "Kurse",
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
                        child: SingleChildScrollView(
                          child: Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: ausgeblendeteKurse!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ausgeblendeterKursWidget(ausgeblendeteKurse![index], setState);
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 20
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
                                List<String> ak = [];

                                for(MapEntry<String, bool> b in changed!.entries){
                                  if(!b.value)
                                    ak.add(b.key);
                                }

                                StorageManager.setString(
                                    StorageKeys.ausgeblendeteKurse, jsonEncode(ak));

                                refresh();
                                Navigator.of(context).pop();
                              },
                              padding: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 15,
                                  bottom: 15
                              ),
                              color: PGUColors.accent,
                              child: Text(
                                "Speichern",
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
              );
            }
          );
        }
    );
  }

  Map<String, bool>? changed;

  Widget ausgeblendeterKursWidget(String kurs, Function setState){
    return Container(
      padding: EdgeInsets.only(
        bottom: 15,
        left: 50,
        right: 50
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              kurs.replaceAll("|", " "),
              style: TextStyle(
                  fontFamily: 'Mont',
                  fontSize: 20
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(changed![kurs]!)
                changed![kurs] = false;
              else
                changed![kurs] = true;

              setState(() {

              });
            },
            child: Icon(
              changed![kurs]! ? Icons.visibility_rounded : Icons.visibility_off_rounded,
              color: PGUColors.background,
            ),
          )
        ],
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }

  void openClasses(){
    NoAnimationRoute.open(context, Classes(false));
  }

  void openSettings(){
    NoAnimationRoute.open(context, Settings());
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
