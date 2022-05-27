import 'package:flutter/material.dart';
import 'package:pgu/Pages/Home/tabs/Classes.dart';
import 'package:pgu/Pages/Home/tabs/Vertretungen.dart';
import 'package:pgu/Pages/Settings/Settings.dart';
import 'package:pgu/Values/Design/PGUColors.dart';

import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double NAVBAR_ICON_SIZE = 27.5;
  List<String> tabTitles = [
    "Klassen",//TODO: Lehrer hinzufügen
    "Vertretungen",
    "Einstellungen"
  ];

  List<IconData> tabIconsUnselected = [
    Icons.person_outline_rounded,
    Icons.home_outlined,
    Icons.settings_outlined
  ];

  List<IconData> tabIconsSelected = [
    Icons.person_rounded,
    Icons.home_rounded,
    Icons.settings_rounded
  ];

  List<Widget> tabWidgets = [
    Classes(),
    Vertretungen(),
    Container(),
  ];

  int currentTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: 70,
                ),
                child: RichText(
                  text: TextSpan(
                      text: "Deine\n",
                      style: const TextStyle(
                          fontFamily: 'Mont-normal',
                          fontSize: 18,
                          color: PGUColors.background
                      ),
                      children: [
                        TextSpan(
                            text: tabTitles[currentTab],
                            style: const TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 32
                            )
                        )
                      ]
                  ),
                ),
              ),
              Expanded(
                child: tabWidgets[currentTab],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 78.5,
              margin: const EdgeInsets.only(
                  bottom: 35,
                  right: 25,
                  left: 25
              ),
              decoration: BoxDecoration(
                color: PGUColors.background,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(width: 0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 7), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: tabTitles.asMap().entries.map((e) => NavigationbarIcon(e.key)).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget NavigationbarIcon(int index){
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            currentTab = index;
          });
        },
        child: Container(
          color: PGUColors.transparent,
          padding: const EdgeInsets.all(20),
          child: Icon(
            currentTab == index ? tabIconsSelected[index] : tabIconsUnselected[index],
            color: PGUColors.text,
            size: NAVBAR_ICON_SIZE,
          ),
        ),
      ),
    );
  }
}
