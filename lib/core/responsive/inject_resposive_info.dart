import 'package:movie_app/core/responsive/device_screen_info.dart';

extension Responsice on num {
  get  h => DeviceScreenInfo.heightPerThousnd()*this;

  get w => DeviceScreenInfo.WidthPerThousnd()*this;

}
