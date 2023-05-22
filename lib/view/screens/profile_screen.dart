import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/view/widgets/auth_button.dart';
import '../../logic/controllers/auth_controller.dart';
import '../../logic/controllers/user_profile_controller.dart';
import '../../utils/theme.dart';
import '../widgets/logout_widgert.dart';
import '../widgets/profile_widget.dart';
import '../widgets/text_utils.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget  {
     ProfileScreen({Key? key}) : super(key: key);
     final controller=Get.put(UserProfileController());
     final authController=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
         ProfileWidget(),
          const SizedBox(height: 10,),
          const Divider(color: Colors.grey,thickness:2 ,),
          const SizedBox(height: 20,),
          const TextUtils(fontSize: 18,
            fontWeight: FontWeight.bold,
            text: 'General',
            color: mainColor,
            underline: TextDecoration.none,
          ),
          const SizedBox(height: 40,),
          LogOutWidget(),
        ],
      ),
    );
  }
}
