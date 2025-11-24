import 'package:flutter/cupertino.dart';

class DeviceScreenInfo {
  static final MediaQueryData _mediaQueryData = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.first,
  );

  static double screenHeight() => _mediaQueryData.size.height;
  static double heightPerThousnd() => _mediaQueryData.size.height/1000;

  static double screenWidth() => _mediaQueryData.size.width;
  static double WidthPerThousnd() => _mediaQueryData.size.width/500;

  static double textCal() => _mediaQueryData.size.shortestSide/500;
}
