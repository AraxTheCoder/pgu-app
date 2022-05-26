import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgu/Extensions/StringExtensions.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/ColorChooser.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  List<Widget> introductionPages = [];

  int currentPageIndex = 0;
  PageController controller = PageController();

  Widget tutorialPage(String description, double scale, Widget example){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Image of Add class Screen
          IgnorePointer(
            child: Transform.scale(
              scale: scale,
              child: example,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 50,
                right: 50,
              top: 50
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: PGUColors.background,
                  fontFamily: 'Mont-normal',
                  fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    //TODO: Maybe Update Sample Widgets
    introductionPages = [
      tutorialPage("Füg einfach deine Klasse/Stufe hinzu und bekomme nur dich betreffende Vertretungen angezeigt!", 0.75, Container(
        height: 300,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
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
                    onPressed: (){},
                    padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                        bottom: 15
                    ),
                    color: PGUColors.accent,
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
      )),
      tutorialPage("Verstecke Kurse die du nicht hast und passe die Fächerbarbe nach deinen Vorlieben an.\n\nSwipe hierzu einfach eine Vertretung nach links!", 0.75, Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: 270,
                height: 80,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255,236,236,236),
                    borderRadius: BorderRadius.circular(15)
                ),
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                clipBehavior: Clip.hardEdge,
                //
                child: Row(
                  children: [
                    Container(
                      width: 15,
                      color: ColorChooser.pickColor("").withOpacity(0.75),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Klasse",
                                style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ("Kurs" + " " + "Vertreter").trimEmpty().arrowFormat(),
                                style: const TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Art".shortVersion(),
                                style: const TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
                                ),
                              ),
                            ),

                            //Rechts
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Raum".arrowFormat(),
                                style: const TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Stunde",
                                style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Datum",
                                style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 17
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
              Container(
                height: 90,
                margin: const EdgeInsets.only(
                    right: 60
                ),
                alignment: Alignment.centerRight,
                // color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.visibility_off_rounded),
                    Text(
                      "Kurs\nverbergen",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 90,
                margin: const EdgeInsets.only(
                    right: 10
                ),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.edit_rounded),
                    Text(
                      "Farbe\nändern",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
      )),
    ];

    super.initState();
  }

  //TODO: Lehrer spezifisch
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              color: PGUColors.text.withAlpha(180),
            ),
          ),
          PageView.builder(
            onPageChanged: (int index){
              setState(() {
                currentPageIndex = index;
              });
            },
            controller: controller,
            itemCount: introductionPages.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => introductionPages[index],
          ),
          GestureDetector(
            onTap: skip,
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(
                  top: 40
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: PGUColors.transparent,
                child: const Text(
                  "Überspringen",
                  style: TextStyle(
                      color: PGUColors.background,
                      fontFamily: 'Mont',
                      fontSize: 17.5
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: next,
            child: Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(
                  right: 20,
                  bottom: 40
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: PGUColors.transparent,
                child: Text(
                  currentPageIndex >= introductionPages.length - 1 ? "Auf geht's" : "Weiter",
                  style: const TextStyle(
                      color: PGUColors.background,
                      fontFamily: 'Mont',
                      fontSize: 17.5
                  ),
                ),
              ),
            ),
          ),
          currentPageIndex != 0 ? GestureDetector(
            onTap: previous,
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(
                  left: 20,
                  bottom: 40
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: PGUColors.transparent,
                child: const Text(
                  "Zurück",
                  style: TextStyle(
                      color: PGUColors.background,
                      fontFamily: 'Mont',
                      fontSize: 17.5
                  ),
                ),
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }

  void previous(){
    controller.previousPage(duration: const Duration(milliseconds: 550), curve: Curves.easeInOutCubic);
  }

  void next(){
    if(currentPageIndex == introductionPages.length - 1){
      skip();
      return;
    }

    controller.nextPage(duration: const Duration(milliseconds: 550), curve: Curves.easeInOutCubic);
  }

  void skip(){
    StorageManager.setString(StorageKeys.tutorialWatched, "true");
    NoAnimationRoute.open(context, const Vertretungen());
  }
}
