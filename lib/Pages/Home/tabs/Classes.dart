import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Formatter/UpperCaseTextFormatter.dart';
import 'package:pgu/Models/ClassModel.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/Keyboard.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'dart:math';

import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
import 'package:pgu/Widgets/intern/EmptyState.dart';

class Classes extends StatefulWidget {
  const Classes({Key? key}) : super(key: key);

  @override
  _ClassesState createState() {
    return _ClassesState();
  }
}

class _ClassesState extends State<Classes> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    loadClasses();
  }

  void loadClasses() {
    String jsonString = StorageManager.getString(StorageKeys.classes);

    items.clear();

    if (jsonString.isNotEmpty) {
      entities = List<ClassModel>.from(json.decode(jsonString).map((model) => ClassModel.fromJson(model)));

      items.addAll(entities.map((e) => ClassModel.item(e, deleteClass)));
    }
  }

  List<ClassModel> entities = [];
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    loadClasses();

    return Stack(
      children: [
        entities.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EmptyState("Keine " + (StorageManager.getString(StorageKeys.loggedIn) == "s" ? "Klassen" : "Kürzel"), 'assets/dog_small_nb_cropped.png'),
            const SizedBox()
          ],
        ) : ShaderMask(
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
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            padding: const EdgeInsets.only(
                top: 15,
                bottom: 85
            ),
            itemBuilder: (BuildContext context, int index) {
              return items[index];
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(
            right: 35,
            bottom: 35
          ),
          child: GestureDetector(
            onTap: addClicked,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: -pi / 4,
                  child: SizedBox(
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
      ],
    );
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
                    Keyboard.close(context);
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            top: 30,
                          ),
                          alignment: Alignment.topCenter,
                          child: Text(
                            (StorageManager.getString(StorageKeys.loggedIn) == "s" ? "Klassen" : "Kürzel") + " hinzufügen",
                            style: const TextStyle(
                              color: PGUColors.background,
                              fontFamily: 'Mont',
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                //top: 25,
                                right: 25,
                                left: 25
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              maxLines: 1,
                              autofocus: false,
                              maxLength: StorageManager.getString(StorageKeys.loggedIn) == "s" ? 2 : 5,
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
                              style: const TextStyle(
                                  color: PGUColors.background,
                                  fontFamily: 'Mont'
                              ),
                              decoration: InputDecoration(
                                fillColor: PGUColors.inputBackground,
                                filled: true,
                                hintText: StorageManager.getString(StorageKeys.loggedIn) == "s" ? "Klassen" : "Kürzel",
                                prefix: const SizedBox(width: 15,),
                                hintStyle: const TextStyle(
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
                          margin: const EdgeInsets.only(
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
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  //validateCode(codeController.text, context);
                                  Keyboard.close(context);

                                  addClass(nameController.text.toUpperCase());
                                },
                                padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    top: 15,
                                    bottom: 15
                                ),
                                color: nameController.text.length < 2 ? PGUColors.red : PGUColors.accent,
                                child: const Text(
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
    if(StorageManager.getString(StorageKeys.loggedIn) == "s"){
      if(className.length < 2) {
        Keyboard.close(context);
        FlushbarHelper.createError(
            message: "So sieht eine Klasse aus: 8b", title: "Zu kurz   : ("
        ).show(context);
        return;
      }

      if(!className.isValidClassname()) {
        Keyboard.close(context);
        FlushbarHelper.createError(
            message: "So sieht eine Klasse aus: 8b", title: "Nope   : ("
        ).show(context);
        return;
      }
    }else{
      if(className.length < 2) {
        Keyboard.close(context);
        FlushbarHelper.createError(
            message: "So sieht ein Kürzel aus: RICH", title: "Zu kurz   : ("
        ).show(context);
        return;
      }
    }

    ClassModel classModel = ClassModel(className);

    if(entities.indexWhere((element) => element.name == classModel.name) == -1) {
      entities.add(classModel);
    }

    print("[Classes] Number of Classes: " + entities.length.toString());

    StorageManager.setString(StorageKeys.classes, jsonEncode(entities));
    StorageManager.setString(StorageKeys.lastFetched, "");

    Navigator.of(context).pop();

    nameController.clear();

    setState(()=>null);
  }

  Dio dio = Dio();

  void deleteClass(ClassModel classCode){
    setState((){
      print("[Classes] Delete " + classCode.name!);
      entities.remove(classCode);
      StorageManager.setString(StorageKeys.classes, jsonEncode(entities));
      StorageManager.setString(StorageKeys.lastFetched, "");
    });
  }
}
