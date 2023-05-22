
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_medicine_box/logic/controllers/auth_controller.dart';
import 'package:i_medicine_box/logic/controllers/user_profile_controller.dart';
import 'package:i_medicine_box/view/screens/profile_screen.dart';
import 'package:intl/intl.dart';

import '../../logic/controllers/main_screen_controller.dart';
import '../../routes/routes.dart';
import '../../utils/my_string.dart';
import '../../utils/theme.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/medical_profile_form_field.dart';
import '../widgets/text_utils.dart';
import 'main_screen.dart';

class EditMedicalProfile extends StatelessWidget {
  EditMedicalProfile({Key? key}) : super(key: key);
  final fromKey=GlobalKey<FormState>();
  final authController=Get.put(AuthController());

  final TextEditingController nameController=TextEditingController();
  final TextEditingController medicalProfileController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            title: const TextUtils(
              color: Colors.white,
              text: "Edit your Name",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              underline: TextDecoration.none,
            ),
            centerTitle: true,
          ),
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
                          const SizedBox(height: 50,),
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
                                return'Edit Your medical profile';
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
                                authController.updateMedicalProfile(medicalProfileController.value.text);
                                Get.offNamed(Routes.mainScreen);
                              },
                              text: 'Save',
                            );
                          }),
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
