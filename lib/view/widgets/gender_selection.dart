import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../utils/theme.dart';

class GenderSelection extends StatelessWidget {

  AuthController authController=Get.put(AuthController());

  GenderSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        ),
      child: Row(
        children: [
          const Text(
            " Gender ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),

          ),
          Row(
            children: [
              Obx(
                ()=> Radio(
                  value: "Male",
                  groupValue: authController.selectedGender.value,
                  onChanged: (value){
                    authController.onChangeGender(value);
                  },
                  activeColor: mainColor,
                  fillColor:MaterialStateProperty.all(mainColor) ,
                ),
              ),
              const Text(
                "Male",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),

            ],
          ),
          const SizedBox(width: 20,),
          Row(
            children: [
              Obx(
                ()=> Radio(
                  value: "Female",
                  groupValue: authController.selectedGender.value,
                  onChanged: (value){
                    authController.onChangeGender(value);

                  },
                  activeColor: mainColor,
                  fillColor:MaterialStateProperty.all(mainColor) ,
                ),
              ),
              const Text(
                "Female",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
