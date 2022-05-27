import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pgu/Models/ClassModel.dart';
import 'package:pgu/Models/Info.dart';
import 'package:pgu/Models/Vertretung.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/ColorChooser.dart';
import 'package:pgu/Values/Consts/AppInfo.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';

import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';
import 'package:pgu/Widgets/intern/EmptyState.dart';

class Vertretungen extends StatefulWidget {
  const Vertretungen({Key? key}) : super(key: key);

  @override
  _VertretungenState createState() {
    return _VertretungenState();
  }
}

class _VertretungenState extends State<Vertretungen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadClasses();
    });

    super.initState();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    if (jsonString.isNotEmpty) {
      classes = List<ClassModel>.from(
          json.decode(jsonString).map((model) => ClassModel.fromJson(model)));

      if(classes.isNotEmpty) {
        loadCachedVertretungen();
      }
    }

    setState(() {
      initialLoaded = true;
    });

    loadVertretungen();
  }

  Dio dio = Dio();
  bool offline = false;

  void loadCachedVertretungen(){
    String jsonString = StorageManager.getString(StorageKeys.vertretungen);

    if (jsonString.isNotEmpty) {
      cachedEntities = List<Vertretung>.from(
          json.decode(jsonString).map((model) => Vertretung.fromJson(model)));
    }

    // setState(() {
    //
    // });
  }

  void showLoading(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return const SpinKitFadingCube(
          color: PGUColors.text,
        );
      }
    );
  }

  void hideLoading(){
    Navigator.of(context).pop('dialog');
  }

  void loadVertretungen() async {
    entities = [];
    bool classnameChange = false;
    if(classes.isEmpty) {
      return;
    }

    String params = "";
    for(int a = 0; a < classes.length; a++){
      ClassModel classCode = classes[a];

      params += classCode.name! + "@";
    }

    params = params.substring(0, params.length - 1);

    print("[Vertretungen] Load " + params);
    showLoading();

    //Response response = await dio.get("https://pgu.backslash-vr.com/api/user/get" + "?code=" + classCode.code!);
    //FIXME: to fetch all old use 'old' instead of 'get'
    String url = "https://pgu.backslash-vr.com/api/user/get" "?type=" + StorageManager.getString(StorageKeys.loggedIn) + "&content=" + params + "&apikey=" + StorageManager.getString(StorageKeys.apikey) + "&lastFetched=" + StorageManager.getString(StorageKeys.lastFetched) + "&version=" + AppInfo.clientVersion.toString();
    print("[Vertretungen] " + url);
    try{
      Response response = await dio.get(url);

      if(response.statusCode == 200){
        String responseData = response.data.toString();

        if(!responseData.startsWith("[") || !responseData.endsWith("]")) {
          print("[Vertretungen] Not fetched");
          print("[Vertretungen] " + responseData);
          hideLoading();

          if(responseData == "Invalid Client Version"){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (b){
                  return StatefulBuilder(
                      builder: (c, setState){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          insetPadding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          elevation: 6,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 500,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                      top: 50,
                                      left: 50
                                  ),
                                  child: RichText(
                                    text: const TextSpan(
                                        text: "Neue\n",
                                        style: TextStyle(
                                            fontFamily: 'Mont-normal',
                                            fontSize: 18,
                                            color: PGUColors.background),
                                        children: [
                                          TextSpan(
                                              text: "Version",
                                              style:
                                              TextStyle(fontFamily: 'Mont', fontSize: 32))
                                        ]),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 35,
                                        bottom: 35,
                                        right: 35,
                                        left: 35
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/amongus.png',
                                          height: 150,
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            child: const Text(
                                              "Um die PGU App zu benutzen, musst du die neuste Version herunterladen.",
                                              style: TextStyle(
                                                  fontFamily: 'Mont-normal',
                                                  fontSize: 18,
                                                  color: PGUColors.background
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 30,
                                      left: 30,
                                      right: 30
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            onPressed: () {
                                              //TODO: Open link
                                              Navigator.of(context).pop('dialog');
                                            },
                                            padding: const EdgeInsets.only(
                                                left: 25,
                                                right: 25,
                                                top: 15,
                                                bottom: 15
                                            ),
                                            color: PGUColors.accent,
                                            child: const Text(
                                              "Herunterladen",
                                              style: TextStyle(
                                                  color: PGUColors.text,
                                                  fontFamily: 'Mont'
                                              ),
                                            ),
                                          )
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
          return;
        }

        print("[Vertretungen] Loaded Subsitutions");
        List<Vertretung> newV = List<Vertretung>.from(
            json.decode(responseData).map((model) => Vertretung.fromJson(model)));
        entities += newV;

        url = "https://pgu.backslash-vr.com/api/user/info";
        response = await dio.get(url);
        if(response.statusCode == 200){
          responseData = response.data.toString();

          if(responseData.startsWith("[") && responseData.endsWith("]")) {
            print("[Vertretungen] Loaded Infos");
            List<Info> infos = List<Info>.from(
                json.decode(responseData).map((model) =>
                    Info.fromJson(model)));

            for(Info i in infos){
              int index = entities.indexWhere((element) => element.datum == i.date);

              if(index >= 0) {
                entities.insert(index, Vertretung("INFO", "/", "/", "/", "/", i.content, i.date));
              }
            }
          }
        }

        StorageManager.setString(StorageKeys.lastFetched, DateTime.now().toString());

        // if(entities.length >= 1 && classCode.name != entities[entities.length - 1].klasse){
        //   classes[a].name = entities[entities.length - 1].klasse;
        //   classnameChange = true;
        // }
        StorageManager.setString(StorageKeys.vertretungen, jsonEncode(entities));
      }
    }on DioError {
      print("[Vertretungen] Offline");
      offline = true;
    }on SocketException catch(s){
      print(s);
      print("[Vertretungen] Offline");
      offline = true;
    }
    //print(url);

    // if(classnameChange) {
    //   StorageManager.setString(StorageKeys.classes, jsonEncode(classes));
    //   StorageManager.setString(StorageKeys.ausgeblendeteKurse, jsonEncode([]));
    // }


    hideLoading();

    if(mounted) {
      setState(()=>null);
    }
  }

  List<ClassModel> classes = [];

  List<Vertretung> entities = [];
  List<Vertretung> cachedEntities = [];
  bool initialLoaded = false;

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    List<Widget> items = vertretungenItems();

    if(!initialLoaded){
      return Container();
    }

    if(entities.isEmpty && cachedEntities.isEmpty){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EmptyState("Keine\nVertretungen", 'assets/dog_small_nb_cropped.png'),
          Align(
            alignment: Alignment.bottomCenter,
            child: hiddenCoursesButton(),
          ),
        ],
      );
    }

    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
          stops: [0.0, 0.05, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => items[index],
      ),
    );
  }

  Widget hiddenCoursesButton(){
    List<String>? ausgeblendeteKurse;

    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty) {
      ausgeblendeteKurse = [];
    } else {
      ausgeblendeteKurse = List<String>.from(jsonDecode(jsonString));
    }

    if(ausgeblendeteKurse.isNotEmpty){
      return GestureDetector(
          onTap: showAusgeblendeteKurse,
          child: Container(
            color: PGUColors.transparent,
            padding: const EdgeInsets.only(
                top: 20,
                bottom: 30
            ),
            child: const Text(
              "Ausgeblendete Kurse anzeigen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Mont'
              ),
            ),
          ),
      );
    }

    return Container();
  }

  List<Widget> vertretungenItems() {
    List<Widget> vertretungenItems = [];

    List<String>? ausgeblendeteKurse;

    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty) {
      ausgeblendeteKurse = [];
    } else {
      ausgeblendeteKurse = List<String>.from(jsonDecode(jsonString));
    }

    for (int a = 0; a < (entities.isNotEmpty ? entities.length : cachedEntities.length); a++) {
      Vertretung v = entities.isNotEmpty ? entities[a] : cachedEntities[a];

      if(!ausgeblendeteKurse.contains(v.klasse! + "|" + v.kurs! + "|" + v.vertreter!.split("→")[0])) {
        vertretungenItems.add(Vertretung.item(v, context, refresh, a));
      }
    }

    // if(ausgeblendeteKurse.isNotEmpty){
    //   vertretungenItems.add(
    //       GestureDetector(
    //         onTap: showAusgeblendeteKurse,
    //         child: Container(
    //           color: PGUColors.transparent,
    //           padding: EdgeInsets.only(
    //               top: 20,
    //               bottom: 30
    //           ),
    //           child: Text(
    //             "Ausgeblendete Kurse anzeigen",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //                 fontFamily: 'Mont'
    //             ),
    //           ),
    //         ),
    //       )
    //   );
    // }
    vertretungenItems.add(hiddenCoursesButton());

    return vertretungenItems;
  }

  void showAusgeblendeteKurse(){
    List<String>? ausgeblendeteKurse;

    String jsonString = StorageManager.getString(StorageKeys.ausgeblendeteKurse);

    if(jsonString.isEmpty) {
      ausgeblendeteKurse = [];
    } else {
      ausgeblendeteKurse = List<String>.from(jsonDecode(jsonString));
    }

    changed = <String, bool>{};

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
                  borderRadius: BorderRadius.circular(20),
                ),
                insetPadding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 100,
                  top: 100
                ),
                elevation: 6,
                backgroundColor: Colors.transparent,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            top: 50,
                          left: 50
                        ),
                        child: RichText(
                          text: const TextSpan(
                              text: "Deine\n",
                              style: TextStyle(
                                  fontFamily: 'Mont-normal',
                                  fontSize: 18,
                                  color: PGUColors.background),
                              children: [
                                TextSpan(
                                    text: "Hassfächer",
                                    style:
                                    TextStyle(fontFamily: 'Mont', fontSize: 32))
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10,
                              right: 25,
                              left: 25
                          ),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ausgeblendeteKurse!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ausgeblendeterKursWidget(ausgeblendeteKurse![index], setState);
                            },
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 30,
                            left: 30,
                            right: 30
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    top: 15,
                                    bottom: 15
                                ),
                                // color: PGUColors.accent,
                                child: const Text(
                                  "Abbrechen",
                                  style: TextStyle(
                                      color: PGUColors.background,
                                      fontFamily: 'Mont'
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  onPressed: () {
                                    List<String> ak = [];

                                    for(MapEntry<String, bool> b in changed!.entries){
                                      if(!b.value) {
                                        ak.add(b.key);
                                      }
                                    }

                                    StorageManager.setString(
                                        StorageKeys.ausgeblendeteKurse, jsonEncode(ak));

                                    refresh();
                                    Navigator.of(context).pop();
                                  },
                                  padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      top: 15,
                                      bottom: 15
                                  ),
                                  color: PGUColors.accent,
                                  child: const Text(
                                    "Speichern",
                                    style: TextStyle(
                                        color: PGUColors.text,
                                        fontFamily: 'Mont'
                                    ),
                                  ),
                                )
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
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: PGUColors.background.withOpacity(0.075),
        borderRadius: BorderRadius.circular(15)
      ),
      margin: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 15,
            color: ColorChooser.pickColor(kurs.split("|")[1]).withOpacity(0.75),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: kurs.split("|")[0] + "\n",
                  style: const TextStyle(
                      fontFamily: 'Mont-normal',
                      fontSize: 15,
                      color: PGUColors.background),
                  children: [
                    TextSpan(
                        text: kurs.split("|")[1] + " " + kurs.split("|")[2],
                        style:
                        const TextStyle(fontFamily: 'Mont', fontSize: 22.5))
                  ]),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(changed![kurs]!) {
                changed![kurs] = false;
              } else {
                changed![kurs] = true;
              }

              setState(() {

              });
            },
            child: Container(
              color: PGUColors.transparent,
              child: Row(
                children: [
                  Text(
                    changed![kurs]! ? "Verbergen" : "Anzeigen",
                    style: const TextStyle(fontFamily: 'Mont-normal', fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    changed![kurs]! ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                    color: PGUColors.background,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
