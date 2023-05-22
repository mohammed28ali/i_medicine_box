import 'package:get/get.dart';

import '../../view/screens/home_screen.dart';
import '../../view/screens/pharmacy_screen.dart';
import '../../view/screens/profile_screen.dart';

class MainScreenController extends GetxController{
  RxInt currentIndex=0.obs;
  final tabs=[
    const HomeScreen(),
    PharmacyScreen(),
    ProfileScreen(),
  ].obs;
  final title=[
    "I-Medicine Box",
    "Pharmacies",
    "Profile"
  ].obs;
}