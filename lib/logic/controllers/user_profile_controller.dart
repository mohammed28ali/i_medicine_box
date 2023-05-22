import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../services/network/user_model.dart';

class UserProfileController extends GetxController {
  FirebaseAuth auth=FirebaseAuth.instance;

  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }


  Rx<UserModel> userModel=UserModel(
      email: "",
      name: "",
      profilePic: "",
      gender: "",
      birthDay: "",
      medicalProf: "",
      uId: '',
      ).obs;

  @override
  void onInit() {
    super.onInit();
     FirebaseFirestore.instance.collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
           if(value.exists){
             userModel.value=
                UserModel.fromJson(value.data() as Map<String,dynamic>);
          }
    });
  }


}