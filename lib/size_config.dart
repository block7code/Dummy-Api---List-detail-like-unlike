import 'package:get/get.dart';

class SizeConfig {
  static final screenWidth = Get.width;
}

double customWidth(double v) {
  return (SizeConfig.screenWidth / 360) * v;
}
