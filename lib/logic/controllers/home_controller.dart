import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_medicine_box/model/box_model.dart';

class HomeController extends GetxController {

  //Rx<List<BoxModel>> meds = Rx<List<BoxModel>>([]);
  RxList<BoxModel> meds=RxList<BoxModel>([]);

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  CollectionReference medicine = FirebaseFirestore.instance.collection('medicine');




  late BoxModel boxModel;
  var itemCount = 0.obs;
  var selectedMn = "".obs;

  //realtime
  late DatabaseReference dbRef;


  var dropdownValue = 'box1'.obs;


  List<String> items = [
    'box1',
    'box2',
    'box3',
    'box4',
    'box5',
    'box6',
    'box7',
  ];


   void setSelected(value){
    dropdownValue.value= value;
  }

  onChangeMn(var mn) {
    selectedMn.value = mn;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    dbRef=FirebaseDatabase.instance.ref();
    collectionReference=firestore.collection("medicine");
    meds.bindStream(getAllMedicine());
  }
  Stream<List<BoxModel>>getAllMedicine()=>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => BoxModel.fromMap(item)).toList());

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
   nameTextEditingController.dispose();
   timeTextEditingController.dispose();
  }

  addMed(String medName, String time,String Mn ,String boxNum) {
    boxModel = BoxModel(medName: medName, time: time, Mn: Mn, boxNum: boxNum);
    meds.add(boxModel);
    itemCount.value = meds.length;
    medicine.doc(medName).set({
      'medName':medName,
      'time':time,
      'Mn':Mn,
      'boxNum':boxNum,
    });

    nameTextEditingController.clear();
    timeTextEditingController;
  }

  removeMed(int index,String medName) {
    meds.removeAt(index);
    itemCount.value = meds.length;
    medicine.doc(medName).delete();
  }

  setTime1(String boxNum,String time){
     dbRef.child(boxNum).child('time1').set(time);
  }

  setTime2(String boxNum,String time){
     dbRef.child(boxNum).child('time2').set(time);
  }

  Future<void> sendNotification(int t) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: t,
          channelKey: 'test_channel',
          title: 'I-Medicine Box',
          body: 'Reminder ! Take Your Medicine',
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
      ),
        schedule: NotificationInterval(
        interval: t,
        preciseAlarm: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier()
    ),
    );

  }

}
