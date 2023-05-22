import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:i_medicine_box/utils/theme.dart';
import 'package:intl/intl.dart';

import '../../logic/controllers/home_controller.dart';
import '../widgets/mn_selection.dart';
import '../widgets/text_utils.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameTextEditingController,
              decoration: const InputDecoration(
              hintText: "Medicine Name",
                labelText: "Medicine Name",
                labelStyle: TextStyle(color: mainColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: mainColor),
                ),
                isDense: true,
              ),
              onChanged: (String?value){
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(()=>DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border:Border.all(color:mainColor,width: 2) ,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ) ,
              child: Padding(
                padding: const EdgeInsets.only(left:120, right:120),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  iconEnabledColor: mainColor,
                  value: controller.dropdownValue.value,
                  items: controller.items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value,style: const TextStyle(fontSize: 20,color: mainColor),));
                  }).toList(),
                  onChanged: (value) {
                    controller.setSelected(value);
                  },
                ),
              ),
            ),),
            const SizedBox(
              height: 8,
            ),
            MnSelection(),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              controller: controller.timeTextEditingController,
              onChanged: (String?value){
              },
              decoration: const InputDecoration(
                hintText: "00:00",
                labelText: "Time",
                labelStyle: TextStyle(color: mainColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: mainColor),
                ),

                isDense: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                controller.addMed(
                    controller.nameTextEditingController.text,
                    controller.timeTextEditingController.text,
                    controller.selectedMn.value,
                    controller.dropdownValue.value
                );
                if(controller.selectedMn.value=="M"){
                  controller.setTime1(controller.dropdownValue.value, controller.timeTextEditingController.text);
                }else if(controller.selectedMn.value=="N"){
                  controller.setTime2(controller.dropdownValue.value, controller.timeTextEditingController.text);
                }
                String int1=controller.timeTextEditingController.value.text;
                String int2=DateFormat('HH:mm').format(DateTime.now());
                DateTime dateTime1 = DateFormat('HH:mm').parse(int1);
                DateTime dateTime2 = DateFormat('HH:mm').parse(int2);
                Duration diff = dateTime1.difference(dateTime2).abs();
                controller.sendNotification(diff.inSeconds);
              },
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                minimumSize: const Size(360,50),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ) ,
              ),
              child: const TextUtils(
                color: Colors.white,
                text: 'Add Medicine',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                underline: TextDecoration.none,
              ) ,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.meds.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text("${controller.meds[index].medName!} -  ${controller.meds[index].boxNum!}"),
                    subtitle: Text("${controller.meds[index].time!}   ${controller.meds[index].Mn!}"),
                    trailing: GestureDetector(
                      child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                      onTap: () {
                        controller.removeMed(index,controller.meds[index].medName!);
                      },
                    ),
                  );
                }),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
