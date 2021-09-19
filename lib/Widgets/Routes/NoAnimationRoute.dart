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

  static void open(BuildContext context, Widget child){
    Navigator.pushAndRemoveUntil(context, NoAnimationRoute(builder: (context) => child), (Route<dynamic> route) => false);
  }
}