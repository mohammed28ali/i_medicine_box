
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_medicine_box/routes/routes.dart';
import 'package:intl/intl.dart';
import '../../logic/controllers/auth_controller.dart';
import '../../utils/my_string.dart';
import '../../utils/theme.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/gender_selection.dart';
import '../widgets/medical_profile_form_field.dart';
import '../widgets/text_utils.dart';

class CompleteUserInfoScreen extends StatelessWidget {
   CompleteUserInfoScreen({Key? key}) : super(key: key);
  final fromKey=GlobalKey<FormState>();
  final authController=Get.find<AuthController>();
  final TextEditingController nameController=TextEditingController();
  final TextEditingController medicalProfileController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,),
                    child: Form(
                      key: fromKey ,
                      child: Column(
                        children: [
                          const SizedBox(height: 22,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              TextUtils(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                text: "Please Complete Your Info",
                                color: mainColor,
                                underline: TextDecoration.none,
                              ),
                            ],
                          ),
                          const SizedBox(height: 40,),
                          GetBuilder<AuthController>(builder: (_){
                            return Stack(
                              children: [
                                Obx(() => CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: authController.isProfilePicPathSet.value == true
                                      ? FileImage(File(authController.profilePicPath.value))
                                  as ImageProvider
                                      : const AssetImage('assets/images/user_profile.png'),
                                  radius: 70,
                                )),
                                Positioned(
                                  bottom: -7,
                                  left: 70,
                                  child: IconButton(
                                    onPressed: ()=>authController.pickImage(),
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(height: 20,),
                          AuthTextFormFiled(
                            controller: nameController,
                            obscureText: false,
                            validator: (value){
                              if(value.toString().length<=2||!RegExp(validationName).hasMatch(value)){
                                return'Enter Full Name';
                              }else{
                                return null;
                              }
                            },
                            prefixIcon:const Icon(Icons.person_pin,color: mainColor,) ,
                            suffixIcon: const Text(''),
                            hintText: 'Enter Your Name',
                          ),
                          const SizedBox(height: 20,),
                          GetBuilder<AuthController>(builder: (_){
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        authController.chooseDate();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                      ),
                                      child: const Text('Select Birth Date'),
                                    ),
                                    Obx(() => Text(
                                      DateFormat("dd-MM-yyyy")
                                          .format(authController.selectedDate.value)
                                          .toString(),
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          color: mainColor,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 20,),
                          GenderSelection(),
                          const SizedBox(height: 20,),
                          Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: const [
                               Text("Enter Your Medical Profile",style: TextStyle(color: mainColor,fontSize: 15),),
                             ],
                           ),
                          const SizedBox(height: 5,),
                          MedicalProfileFormFiled(
                            controller: medicalProfileController,
                            obscureText: false,
                            validator: (value){
                              if(value.toString().length<=2||!RegExp(validationName).hasMatch(value)){
                                return'Enter full medical profile';
                              }else{
                                return null;
                              }
                            },
                            hintText: '',
                          ),
                          const SizedBox(height: 50,),
                          GetBuilder<AuthController>(builder: (_){
                            return AuthButton(
                              onPressed: (){
                                authController.completeUserInfo(
                                  image:authController.profilePhoto ,
                                  name:nameController.text.trim() ,
                                  gender:authController.selectedGender.value ,
                                  medicalProf:medicalProfileController.text ,
                                  birthDay: authController.selectedDate.value.toString(),
                                );
                                Get.offNamed(Routes.mainScreen);
                                },
                              text: 'Save',
                            );
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
