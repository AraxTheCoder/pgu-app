import 'package:flutter/material.dart';
import 'package:pgu/Pages/Vertretungen/Vertretungen.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  List<Widget> introductionPages = [

  ];

  int currentPageIndex = 0;
  PageController controller = PageController(viewportFraction: 1.0);

  Widget intoductionPage(String description){
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
          left: 50,
          right: 50
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Image of Add class Screen
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: PGUColors.background,
                fontFamily: 'Mont-normal',
                fontSize: TextSize.medium
            ),
          )
        ],
      ),
    );
  }

  //TODO: Lehrer spezifisch
  @override
  Widget build(BuildContext context) {
    introductionPages = [
      intoductionPage("Füg einfach deine Klasse/Stufe hinzu und bekomme nur dich betreffende Vertretungen angezeigt"),
      intoductionPage("Verstecke Kurse die du nicht hast und passe die Fächerbarbe nach deinen Vorlieben an"),
    ];

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: PGUColors.text,
        body: Stack(
          children: [
            PageView.builder(
              onPageChanged: (int index){
                setState(() {
                  currentPageIndex = index;
                });
              },
              controller: controller,
              itemCount: introductionPages.length,
              itemBuilder: (context, index) {
                //currentPageIndex = index;

                return introductionPages[index];
              },
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
                  child: const Text(
                    "Überspringen",
                    style: TextStyle(
                        color: PGUColors.background,
                        fontFamily: 'Mont-normal',
                        fontSize: 15
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
                  child: Text(
                    currentPageIndex >= introductionPages.length - 1 ? "Auf geht's" : "Weiter",
                    style: const TextStyle(
                        color: PGUColors.background,
                        fontFamily: 'Mont-normal',
                        fontSize: 15
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
                  child: const Text(
                    "Zurück",
                    style: TextStyle(
                        color: PGUColors.background,
                        fontFamily: 'Mont-normal',
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  void previous(){
    controller.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
  }

  void next(){
    if(currentPageIndex == introductionPages.length - 1){
      skip();
      return;
    }

    controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
  }

  void skip(){
    StorageManager.setString(StorageKeys.tutorialWatched, "true");
    NoAnimationRoute.open(context, const Vertretungen());
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async{
    return false;
  }
}
