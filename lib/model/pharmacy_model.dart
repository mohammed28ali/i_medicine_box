import 'package:cloud_firestore/cloud_firestore.dart';

class PharmaciesModel{
  late String pharmacyName;
  late String pharmacyLocation;

  PharmaciesModel({
    required this.pharmacyName,
    required this.pharmacyLocation,
  });
  PharmaciesModel.fromMap(DocumentSnapshot date){
    pharmacyName=date["pharmacyName"];
    pharmacyLocation=date["pharmacyLocation"];
  }
}
