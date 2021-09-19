import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pgu/Pages/Login/Login.dart';
import 'package:pgu/Utils/ImageChecker.dart';
import 'package:pgu/Values/Consts/Consts.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Image/PlanImage.dart';
import 'package:pgu/Widgets/Input/Button/RoundOutlinedButton.dart';
import 'package:pgu/Widgets/Routes/NoAnimationRoute.dart';

class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {

  bool multipleToday = false;
  bool multipleTomorrow = false;

  //0 = Today | 1 = Tomorrow
  int dayIndex = 0;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    checkMultipleToday();
    checkMultipleTomorrow();

    //deleteAllImagesFromCache();
    deleteTodayImagesFromCache();
    deleteTomorrowImagesFromCache();
  }

  void deleteTodayImagesFromCache(){
    NetworkImage p = NetworkImage(singleToday);
    p.evict();

    p = NetworkImage(multipleToday1);
    p.evict();
    p = NetworkImage(multipleToday2);
    p.evict();
  }

  void deleteTomorrowImagesFromCache(){
    NetworkImage p = NetworkImage(singleTomorrow);
    p.evict();

    p = NetworkImage(multipleTomorrow1);
    p.evict();
    p = NetworkImage(multipleTomorrow2);
    p.evict();
  }

  void checkMultipleToday() async{
    await ImageChecker.checkMutipleToday().then((value){
        multipleToday = value;
        print("Multiple Today: " + multipleToday.toString());
    });
  }

  void checkMultipleTomorrow() async{
    await ImageChecker.checkMutipleTomorrow().then((value){
      multipleTomorrow = value;
      print("Multiple Tomorrow: " + multipleTomorrow.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: PGUColors.background,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
                //height: Consts.IMAGE_RATIO * (SDP.width + 75),
              //color: Colors.cyan,
              margin: EdgeInsets.only(
                left: SDP.sdp(10),
                right: SDP.sdp(10),
                top: SDP.sdp(75),
                bottom: SDP.sdp(100)
              ),
              child: loadImage()
            ),
            Container(
              width: double.infinity,
              height: SDP.sdp(75),
              color: PGUColors.background,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: SDP.sdp(SDP.safepaddingtop),
                  left: SDP.sdp(10)
              ),
              child: Text(
                "Vertretungsplan",
                style: TextStyle(
                    color: PGUColors.text,
                    fontFamily: 'Mont',
                    fontSize: TextSize.big
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: SDP.sdp(25),
                  right: SDP.sdp(25),
                  left: SDP.sdp(25)
                ),
                child: Container(
                  height: SDP.sdp(60),
                  padding: EdgeInsets.only(
                    top: SDP.sdp(10)
                  ),
                  decoration: BoxDecoration(
                    color: PGUColors.text,
                    borderRadius: BorderRadius.circular(SDP.sdp(30))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundOutlinedButton("Heute", getButtonColor(0), textColor: getTextColor(0), paddingRight: 5, paddingLeft: 10, onClick: todayClicked,),
                      ),
                      Expanded(child: RoundOutlinedButton("Morgen", getButtonColor(1), textColor: getTextColor(1), paddingLeft: 5, paddingRight: 10, onClick: tomorrowClicked,))
                    ],
                  ),
                ),
              ),
            ),
            pageDown()
          ],
        )
      ),
    );
  }

  void todayClicked(){
    setState(() {
      dayIndex = 0;
      pageIndex = 0;
    });
  }

  void tomorrowClicked(){
    setState(() {
      dayIndex = 1;
      pageIndex = 0;
    });
  }

  Color getTextColor(int index){
    if(dayIndex == index){
      return PGUColors.text;
    }else{
      return PGUColors.background;
    }
  }

  Color getButtonColor(int index){
    if(dayIndex == index){
      return PGUColors.background;
    }else{
      return PGUColors.text;
    }
  }

  static const String singleToday = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler.png";
  static const String multipleToday1 = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler-0.png";
  static const String multipleToday2 = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler-1.png";

  static const String singleTomorrow = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler.png";
  static const String multipleTomorrow1 = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler-0.png";
  static const String multipleTomorrow2 = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler-1.png";

  Widget loadImage(){
    PlanImage.controller.reset();
    if(dayIndex == 0){
      if(!multipleToday){
        return PlanImage.PlanImageWidget(singleToday, refresh);
      }else{
        if(pageIndex == 0){
          return PlanImage.PlanImageWidget(multipleToday1, refresh);
        }else {
          return PlanImage.PlanImageWidget(multipleToday2, refresh);
        }
      }
    }else{
      if(!multipleTomorrow){
        return PlanImage.PlanImageWidget(singleTomorrow, refresh);
      }else{
        if(pageIndex == 0){
          return PlanImage.PlanImageWidget(multipleTomorrow1, refresh);
        }else {
          return PlanImage.PlanImageWidget(multipleTomorrow2, refresh);
        }
      }
    }
  }

  void refresh(){
    NoAnimationRoute.open(context, Plans());
  }

  Widget pageDown(){
    if(dayIndex == 0 && multipleToday){
      if(pageIndex == 0)
        return arrow(false);
      else
        return arrow(true);
    }

    if(dayIndex == 1 && multipleTomorrow){
      if(pageIndex == 0)
        return arrow(false);
      else
        return arrow(true);
    }

    return Container();
  }

  Widget arrow(bool up){
    return GestureDetector(
      onTap: (){
        updatePage(up);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: SDP.sdp(95),
              right: SDP.sdp(25)
          ),
          child: Container(
            width: SDP.sdp(50),
            height: SDP.sdp(50),
            decoration: BoxDecoration(
                color: PGUColors.text,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Icon(
              up ? Icons.arrow_upward : Icons.arrow_downward,
              color: PGUColors.background,
              size: SDP.sdp(25),
            ),
          ),
        ),
      ),
    );
  }

  void updatePage(bool up){
    setState(() {
      if(up)
        pageIndex--;
      else
        pageIndex++;
    });
  }

  //Just return false -> Don't left the App
  Future<bool> onBackPressed() async {
    //NoAnimationRoute.open(context, Login());
    return false;
  }
}
