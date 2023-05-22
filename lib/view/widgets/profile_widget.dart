import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/view/widgets/text_utils.dart';
import '../../logic/controllers/auth_controller.dart';
import '../../logic/controllers/user_profile_controller.dart';
import '../../utils/theme.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/edite_medical_profile_screen.dart';
import 'auth_button.dart';

class ProfileWidget extends StatelessWidget  {
   ProfileWidget({Key? key}) : super(key: key);

  final controller=Get.put(UserProfileController());
  final authController=Get.put(AuthController());


   @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 85,),
                Hero(
                  tag: 'profile photo ',
                  child: Obx(()=>
                  controller.userModel.value.profilePic==""?
                  const CircleAvatar(backgroundImage: AssetImage('assets/images/user_profile.png'),
                    maxRadius: 70,
                  ):CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        controller.userModel.value.profilePic
                    ),
                    maxRadius: 70,
                  ),
                  ),
                ),
              ],
            ),
            GetBuilder<UserProfileController>(builder: (_){
              return Container(
                width: double.infinity,
                margin:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: mainColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.person,color: mainColor,),
                    Obx(() =>TextUtils(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      text: controller.userModel.value.name==""?"Empty Name":controller.capitalize(controller.userModel.value.name),
                      color: Colors.black,
                      underline: TextDecoration.none,
                    )),
                    IconButton(
                        onPressed: (){
                      Get.off(()=>EditProfileScreen());
                    },
                        icon: const Icon(Icons.edit,color: mainColor,)),
                  ],
                ),
              );
            }),
            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: mainColor,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email,color: mainColor,),
                  const SizedBox(width: 20,),
                  TextUtils(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    text: controller.userModel.value.email,
                    color: Colors.black,
                    underline: TextDecoration.none,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: mainColor,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month,color: mainColor,),
                  const SizedBox(width: 20,),
                  Obx(()=>TextUtils(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    text: controller.userModel.value.birthDay==""?"No Birth Day":controller.userModel.value.birthDay.substring(0,10),
                    color: Colors.black,
                    underline: TextDecoration.none,
                  )),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height:100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: mainColor,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info,color: mainColor,),
                  const SizedBox(width: 20,),
                  TextUtils(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    text: controller.userModel.value.medicalProf==""?"No Medical Profile":controller.userModel.value.medicalProf,
                    color: Colors.black,
                    underline: TextDecoration.none,
                  ),
                  const SizedBox(width: 170,),
                ],
              ),
            ),
            AuthButton(text: 'Edit Your Medical Profile', onPressed: () {
              Get.off(()=>EditMedicalProfile());
            },),
          ],
        ),)
      ],
    );
  }
}
