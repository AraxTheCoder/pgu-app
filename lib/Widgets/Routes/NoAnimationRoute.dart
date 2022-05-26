import 'package:flutter/material.dart';

class NoAnimationRoute<T> extends MaterialPageRoute<T> {
  NoAnimationRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      maintainState: maintainState,
      settings: settings,
      fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  //TODO: Open should be replaced by push
  static void open(BuildContext context, Widget child){
    print("[NoAnimationRoute] Open new route");
    Navigator.pushAndRemoveUntil(context, NoAnimationRoute(builder: (context) => child), (Route<dynamic> route) => false);
  }

  static void push(BuildContext context, Widget child){
    print("[NoAnimationRoute] Push new route");
    Navigator.push(context, NoAnimationRoute(builder: (context) => child));
  }

  static void pushRefresh(BuildContext context, Widget child, Function setState){
    if(MediaQuery.of(context).viewInsets.bottom == 0){
      print("[NoAnimationRoute] Push refresh new route");
      Navigator.push(context, NoAnimationRoute(builder: (context) => child)).then((value) => setState((){
        print("[NoAnimationRoute] Refresh");
      }));
    }else{
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild?.unfocus();
        //searchController.clear();
      }
    }
  }

  static void pop(BuildContext context, {int popCount = 1}){
    print("[NoAnimationRoute] Pop route");

    int count = 0;

    Navigator.popUntil(context, (route) {
      return count++ == popCount;
    });
  }

  static void openWithKey(GlobalKey<NavigatorState> key, Widget child){
    print("[NoAnimationRoute] Open new route with key");
    key.currentState?.pushAndRemoveUntil(NoAnimationRoute(builder: (context) => child), (Route<dynamic> route) => false);
  }
}