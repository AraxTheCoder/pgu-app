import 'package:flutter/material.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Widgets/intern/EmptyState.dart';

import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 35,
        right: 35
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text("Source Code",
                style: TextStyle(
                    fontFamily: 'Mont',
                    fontSize: 20
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await launch("https://github.com/AraxTheCoder/pgu-app");
                },
                child: Container(
                  color: PGUColors.transparent,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "github.com/AraxTheCoder/pgu-app",
                    style: TextStyle(
                        fontFamily: 'Mont-normal',
                        fontSize: 15,
                        color: PGUColors.blue
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("Kontakt",
                style: TextStyle(
                    fontFamily: 'Mont',
                    fontSize: 20
                ),
              ),
              const Text("Bei Fehlern oder Wünschen",
                style: TextStyle(
                    fontFamily: 'Mont',
                    fontSize: 15
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await launch("mailto:krueger.jonathan@gmx.de?subject=PGU%20App%20Fehler%20oder%20Wunsch");
                },
                child: Container(
                  color: PGUColors.transparent,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "krueger.jonathan@gmx.de",
                    style: TextStyle(
                        fontFamily: 'Mont-normal',
                        fontSize: 15,
                        color: PGUColors.blue
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmptyState("Baustelle", 'assets/baustelle_cropped.png')
              ],
            ),
          )
        ],
      ),
    );
  }
}
