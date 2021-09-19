import 'package:flutter/material.dart';
import 'package:pgu/Pages/Plans/Plans.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';
import 'package:pgu/Utils/CredentialUtils.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Input/Button/RoundOutlinedButton.dart';
import 'package:pgu/Widgets/Input/Text/RoundFilledInput.dart';
import 'package:pgu/Widgets/Output/FlushbarHelper.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

/*
 * By: AraxTheCoder 19.03.2021
 */

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() {
    return _IntroductionState();
  }
}

class _IntroductionState extends State<Introduction> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Container(
        //resizeToAvoidBottomPadding: true,
        // resizeToAvoidBottomInset: true,
        color: Color.fromARGB(255, 97, 202, 151),
      ),
    );
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    return false;
  }
}
