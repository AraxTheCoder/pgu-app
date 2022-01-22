import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'size_change_notifier.dart';

class ActionItems extends Object{
  ActionItems({required this.icon, required this.text ,required this.onPress, this.backgroudColor:Colors.grey});

  final Widget icon;
  final String text;
  final VoidCallback onPress;
  final Color backgroudColor;
}

class OnSlide extends StatefulWidget {
  OnSlide({Key? key, required this.items, required this.child, this.backgroundColor:Colors.white}):super(key:key){
    assert(items.length <= 6);
  }

  final List<ActionItems> items;
  final Widget child;
  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() {
    return new _OnSlideState();
  }
}
class _OnSlideState extends State<OnSlide> {
  ScrollController controller = new ScrollController();
  bool isOpen = false;

  Size? childSize;
  GlobalKey key = GlobalKey();
  int? oldY;

  static const double iconWidth = 70.0;
  double iconWidth10 = iconWidth + 10.0;

  @override
  void initState() {
    super.initState();
  }

  bool _handleScrollNotification(dynamic notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >= (widget.items.length * iconWidth10)/2
          && notification.metrics.pixels < widget.items.length * iconWidth10){
        scheduleMicrotask((){
          controller.animateTo(widget.items.length * iconWidth,
              duration: new Duration(milliseconds: 600), curve: Curves.decelerate);

          Timer(Duration(seconds: 1), (){
            scheduleMicrotask((){
              if(controller.positions.isNotEmpty)
                controller.animateTo(0.0, duration: new Duration(milliseconds: 600), curve: Curves.decelerate);
            });
          });
        });
      }else if (notification.metrics.pixels > 0.0 && notification.metrics.pixels < (widget.items.length * iconWidth10)/2){
        scheduleMicrotask((){
          controller.animateTo(0.0, duration: new Duration(milliseconds: 600), curve: Curves.decelerate);
        });
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (childSize == null){
      return new NotificationListener(
        child: new LayoutSizeChangeNotifier(
          child: widget.child
        ),
        onNotification: (LayoutSizeChangeNotification notification){
          childSize = notification.newSize;
          //print(notification.newSize);

          scheduleMicrotask((){
            if(!mounted)
              return;

            setState((){
            });
          });

          return true;
        },

      );
    }

    List<Widget> above = <Widget>[new Container(
      width: childSize!.width,
      height: childSize!.height,
      color: widget.backgroundColor,
      child: GestureDetector(
        onTap: (){
          //controller.jumpTo(2.0);
          controller.animateTo(0.0, duration: new Duration(milliseconds: 200), curve: Curves.decelerate);
        },
        child: widget.child,
      ),
    ),];

    for (ActionItems item in widget.items){
      above.add(
          new GestureDetector(//InkWell
              child: new Container(
                alignment: Alignment.centerLeft,
                width: iconWidth,
                height: childSize!.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.icon,
                    Text(
                      item.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Mont',
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                controller.jumpTo(0.0);
                item.onPress();
              }
          )
      );
    }

    Widget items = new Container(
      width: childSize!.width,
      height: childSize!.height,
    );

    Widget scrollview = new NotificationListener(
      child: ListView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: above,
      ),
      onNotification: _handleScrollNotification,
    );

    return Stack(
      key: key,
      children: <Widget>[
        items,
        Positioned(child: scrollview, left: 0.0, bottom: 0.0, right: 0.0, top: 0.0,)
      ],
    );
  }
}