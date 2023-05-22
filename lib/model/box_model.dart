import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoxModel {
   String? medName;
   String? time;
   String? Mn;
   String? boxNum;


  BoxModel({
    @required this.medName,
    @required this.time,
    @required this.Mn,
    @required this.boxNum,
  });

  BoxModel.fromMap(DocumentSnapshot date){
    medName=date["medName"];
    time=date["time"];
    Mn=date["Mn"];
    boxNum=date["boxNum"];

  }
}
