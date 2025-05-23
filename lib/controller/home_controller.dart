import 'package:get/get.dart';

class HomeController extends GetxController {
  void navigateToHoroscope() {
    Get.toNamed('/horoscope'); // ใช้ GetX สำหรับ navigation
  }

  void navigateToTarot() {
    Get.toNamed('/tarot');
  }
}
