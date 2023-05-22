import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/logic/controllers/home_controller.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../utils/theme.dart';

class MnSelection extends StatelessWidget {

  HomeController homeController=Get.put(HomeController());

  MnSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 70,),
          Row(
            children: [
              Obx(
                    ()=> Radio(
                  value: "M",
                  groupValue: homeController.selectedMn.value,
                  onChanged: (value){
                    homeController.onChangeMn(value);
                  },
                  activeColor: mainColor,
                  fillColor:MaterialStateProperty.all(mainColor) ,
                ),
              ),
              const Text(
                "M",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),

            ],
          ),
          const SizedBox(width: 50,),
          Row(
            children: [
              Obx(
                    ()=> Radio(
                  value: "N",
                  groupValue: homeController.selectedMn.value,
                  onChanged: (value){
                    homeController.onChangeMn(value);

                  },
                  activeColor: mainColor,
                  fillColor:MaterialStateProperty.all(mainColor) ,
                ),
              ),
              const Text(
                "N",
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
