import 'package:pgu/Values/Size/SDP.dart';

class TextSize{
  static double small;
  static double medium;
  static double big;

  static void build() {
    small = SDP.sdp(10);
    medium = SDP.sdp(13.5);
    big = SDP.sdp(27.5);
  }
}