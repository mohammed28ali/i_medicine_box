import 'package:get/get.dart';
import 'package:i_medicine_box/view/screens/cmplete_userInfo_screen.dart';
import 'package:i_medicine_box/view/screens/home_screen.dart';
import 'package:i_medicine_box/view/screens/main_screen.dart';
import '../logic/binidings/auth_binding.dart';
import '../logic/binidings/home_binding.dart';
import '../logic/binidings/main_binding.dart';
import '../logic/binidings/spalsh_biniding.dart';
import '../view/screens/auth/forget_pass_screen.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/splash_screen.dart';

class AppRoutes{
  //initial route
  static const splash=Routes.splashScreen;
  static const mainScreen=Routes.mainScreen;

  //getPages
  static final routes=
  [
    GetPage(
        name: Routes.splashScreen,
        page: ()=> const SplashScreen(),
        binding: SplashBinding(),
  ),
    GetPage(
        name: Routes.loginScreen,
        page: ()=> LoginScreen(),
        binding: AuthBinding(),
    ),
    GetPage(
        name: Routes.mainScreen,
        page: ()=> MainScreen(),
        bindings: [AuthBinding(),MainBinding(),HomeBinding()]
    ),
    GetPage(
        name: Routes.forgetPassScreen,
        page: ()=> ForgetPassScreen(),
        binding: AuthBinding(),
    ),
    GetPage(
        name: Routes.completeUserInfoScreen,
        page: ()=> CompleteUserInfoScreen(),
        binding: AuthBinding(),
    ),
    GetPage(
        name: Routes.homeScreen,
        page: ()=> const HomeScreen(),
        bindings: [AuthBinding(),HomeBinding()],
    ),
  ];
}

class Routes{
  static const splashScreen='/splashScreen';
  static const loginScreen='/loginScreen';
  static const mainScreen='/mainScreen';
  static const forgetPassScreen='/forgetPassScreen';
  static const completeUserInfoScreen='/completeUserInfoScreen';
  static const homeScreen='/homeScreen';
}