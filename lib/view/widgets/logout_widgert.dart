import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/view/widgets/text_utils.dart';
import '../../logic/controllers/auth_controller.dart';
import '../../utils/theme.dart';



class LogOutWidget extends StatelessWidget {
  LogOutWidget({Key? key}) : super(key: key);

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Logout From App",
              titleStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText: 'Are you sure you need to logout',
              middleTextStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.grey,
              radius: 30,
              textCancel: " No ",
              buttonColor: mainColor,
              cancelTextColor: Colors.white,
              textConfirm: " YES ",
              confirmTextColor: Colors.white,
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                controller.signOutFromApp();
              },
            );
          },
          splashColor: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          customBorder: const StadiumBorder(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: logOutSettings,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              TextUtils(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                text: "Logout".tr,
                color: Colors.black,
                underline: TextDecoration.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}