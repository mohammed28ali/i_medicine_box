
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/view/widgets/auth_button.dart';

import '../../logic/controllers/pharmacies_controller.dart';
import '../../utils/theme.dart';
import '../widgets/text_utils.dart';

class PharmacyScreen extends StatelessWidget {
   PharmacyScreen({Key? key}) : super(key: key);
  final pharmaciesController = Get.put(PharmaciesController());

   @override
   Widget build(BuildContext context) {
     return Obx(() => ListView.builder(
       itemCount: pharmaciesController.pharmacies.length,
       itemBuilder: (context, index) => Card(
         child: Container(
           width: double.infinity,
           margin:
           const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
           height: 150,
           decoration: BoxDecoration(
             color: Colors.grey.shade100,
             borderRadius: BorderRadius.circular(20),
             border: Border.all(
               color: mainColor,
             ),
           ),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               ListTile(
                 title: TextUtils(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   text: pharmaciesController.pharmacies[index].pharmacyName.toString(),
                   color: mainColor,
                   underline: TextDecoration.none,
                 ),
                 leading: CircleAvatar(
                   radius: 20,
                   backgroundColor: mainColor,
                   child:TextUtils(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     text: pharmaciesController.pharmacies[index].pharmacyName.substring(0, 1).capitalize!,
                     color: Colors.white,
                     underline: TextDecoration.none,
                   ) ,
                 ),
                 //trailing: (),
                 onTap: () {},
               ),
               const SizedBox(
                 height: 22,),
               AuthButton(
                 text:"GO To Location" ,
                 onPressed: () {
                   pharmaciesController.launchURL(pharmaciesController.pharmacies[index].pharmacyLocation.toString());
                 },
               ),
             ],
           ),
         ),
       ),
     ),
     );

   }
}
