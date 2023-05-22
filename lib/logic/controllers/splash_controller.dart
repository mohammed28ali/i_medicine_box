import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 5000),() {
      Get.offNamed(Routes.loginScreen);
    });
    }


  @override
  void onClose() {
    super.onClose();
  }
}