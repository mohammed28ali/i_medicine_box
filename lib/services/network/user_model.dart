import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uId;
  String email;
  String name;
  String profilePic;
  String gender;
  String medicalProf;
  String birthDay;


  UserModel({
     required this.uId,
     required this.email,
     required this.name,
     required this.profilePic,
     required this.gender,
     required this.medicalProf,
     required this.birthDay,
  });





  toJson() {
    return {
      'uId': uId,
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'gender': gender,
      'medicalProf': medicalProf,
      'birthDay': birthDay,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      profilePic: json["profilePic"],
      email:json["email"],
      birthDay: json["birthDay"],
      medicalProf: json["medicalProf"],
      gender: json["gender"],
      uId: json["uId"],
  );


  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      uId: snapshot['uId'],
      name: snapshot['name'],
      profilePic: snapshot['profilePic'],
      gender: snapshot['gender'],
      medicalProf: snapshot['medicalProf'],
      birthDay: snapshot["birthDay"],
    );
  }


}