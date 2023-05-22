import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/logic/controllers/main_screen_controller.dart';
import 'package:i_medicine_box/utils/theme.dart';

class MainScreen extends StatelessWidget {
   MainScreen({Key? key}) : super(key: key);

  final controller=Get.find<MainScreenController>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
          child: Obx((){
            return Scaffold(
              appBar: AppBar(
                title: Text(controller.title[controller.currentIndex.value]),
                centerTitle: true,
                backgroundColor: mainColor,
                elevation: 0.0,
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex:controller.currentIndex.value,
                type: BottomNavigationBarType.shifting,
                iconSize: 35.0,
                items:
                const [
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.home,color: mainColor,),
                      icon: Icon(Icons.home,color: mainColor5,),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.local_pharmacy,color: mainColor,),
                      icon: Icon(Icons.local_pharmacy,color: mainColor5,),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.person_pin,color: mainColor,),
                      icon: Icon(Icons.person_pin,color: mainColor5,),
                      label: ''
                  ),
                ],
                onTap: (index){
                  controller.currentIndex.value=index;
                },
              ),
              body: IndexedStack(
                index: controller.currentIndex.value,
                children: controller.tabs.value,
              ),
            );
          }),
      ),
    );
  }
}
