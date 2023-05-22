import 'package:get/get.dart';
import 'package:i_medicine_box/logic/controllers/main_screen_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainScreenController());
  }

}