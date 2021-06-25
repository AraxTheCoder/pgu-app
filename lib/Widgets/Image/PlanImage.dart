import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pgu/Values/Consts/Consts.dart';
import 'package:pgu/Values/Design/PGUColors.dart';
import 'package:pgu/Values/Size/SDP.dart';
import 'package:pgu/Values/Size/TextSize.dart';
import 'package:pgu/Widgets/Input/Button/RoundOutlinedButton.dart';

import 'package:photo_view/photo_view.dart';

class PlanImage{
  static PhotoViewController controller = PhotoViewController();

  static Widget PlanImageWidget(String src, Function retryClick) {
    if (PGUColors.brightness == Brightness.dark) {
      return Image.network(
        src,
        errorBuilder: (c, o, st) {
          if(o != null){
            //FIXME For Debug
            //print((o as Exception));
            if((o as Exception).toString().contains(Consts.ERROR_NO_INTERNET)){
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/dog_small_nb.png'),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Text(
                          "Kein Internet",
                          style: TextStyle(
                            fontSize: TextSize.big,
                            fontFamily: 'Mont',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = PGUColors.background,
                          ),
                        ),
                        Text(
                          "Kein Internet",
                          style: TextStyle(
                            color: PGUColors.text,
                            fontSize: TextSize.big,
                            fontFamily: 'Mont',
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(10.0, 10.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(10.0, 10.0),
                                blurRadius: 8.0,
                                color: Color.fromARGB(125, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SDP.sdp(100)
                      ),
                      child: Container(
                        width: SDP.sdp(200),
                        height: SDP.sdp(35),
                        child: RoundOutlinedButton(
                          "Retry",
                          PGUColors.text,
                          textColor: PGUColors.background,
                          paddingTop: SDP.sdp(0),
                          fontSize: TextSize.medium,
                          height: SDP.sdp(35),
                          onClick: retryClick,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }else{
              return Container();
            }
          }else{
            return Container();
          }
        },
        loadingBuilder: (c, widget, loading) {
          if (loading == null) {
            return ClipRect(
              child: PhotoView.customChild(
                maxScale: 3.0,
                minScale: 1.0,
                controller: controller,
                child: ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      //R  G   B    A  Const
                      -1, 0, 0, 0, 255, //
                      0, -1, 0, 0, 255, //
                      0, 0, -1, 0, 255, //
                      0, 0, 0, 1, 0, //
                    ]),
                    child: widget),
              ),
            );
          }else{
            return Container();
          }
        },
      );
    } else {
      return Container();
    }
  }
}
