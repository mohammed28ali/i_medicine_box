import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i_medicine_box/routes/routes.dart';
import 'package:i_medicine_box/services/network/user_model.dart';
import 'package:i_medicine_box/utils/theme.dart';
import 'package:i_medicine_box/view/screens/auth/login_screen.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  bool isVisibility = false;
  var isSignedIn = false;
  var isGotoComInfo = false;
  var selectedGender = "".obs;
  var displayUserName = ''.obs;
  var displayUserEmail = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayGender = '';
  var profilePicLink='';
  var isProfilePicPathSet = false.obs;
  var profilePicPath = "".obs;
  var selectedDate = DateTime.now().obs;



  final GetStorage authBox = GetStorage();
  static AuthController instance = Get.find();


  User? get userProfile => auth.currentUser;
  User? user = FirebaseAuth.instance.currentUser;
  late Rx<User?> _user;

  late Rx<File?> _pickedImage;
  File? pickedFile;
  File? get profilePhoto => _pickedImage.value ;



  //FIREBASE
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  //user collection
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  @override
  void onInit(){
    super.onInit();
    displayUserEmail.value = (userProfile != null ? userProfile!.email : "")!;

  }

  void visibility() {
    isVisibility = !isVisibility;
    update();
  }
  onChangeGender(var gender) {
    selectedGender.value = gender;
    update();
  }

  void loginUsingFirebase({
    required String email,
    required String password,
    String?name,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value){
      });

      isSignedIn = true;

      authBox.write("auth", isSignedIn);

      update();
      if(GetStorage().read<bool>("completeInfo") ==true){
      Get.offNamed(Routes.mainScreen);
      }else{
        Get.offNamed(Routes.completeUserInfoScreen);
      }

    } on FirebaseAuthException catch (error) {
      String title = error.code
          .replaceAll(RegExp('-'), ' ')
          .capitalize!;
      String message = '';
      if (error.code == 'user-not-found') {
        message =
        'Account does not exists for that $email..Create your account by signing up.. ';
      } else if (error.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }


  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String profilePic,
    required String gender,
    required String medicalProf,
    required String birthDay,
}){
    UserModel model=UserModel(
        uId: uId,
        email: email,
        name: name,
        profilePic: profilePic,
        gender:gender ,
        medicalProf:medicalProf,
        birthDay: birthDay,
    );
    firestore.collection('users').doc(uId).set(
      model.toJson()
    ).then((value) {}).catchError((error){});
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'user-not-found') {
        message = 'Account does not exists for that $email';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void signOutFromApp() async {
    try {
      await auth.signOut();
      isSignedIn = false;
      authBox.remove("auth");
      update();
      Get.offAll(LoginScreen());
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProfilePicPathSet.value = true;
  }

  void pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
      pickedFile = File(pickedImage.path);
      setProfileImagePath(pickedFile!.path);
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
    update();
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(user!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    ref.getDownloadURL().then((value) async{
      profilePicLink=value ;
      update();

    });
    return downloadUrl;
  }

  //choose Birth Date
  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(1900),
        lastDate: DateTime(2024),
        helpText: 'Select DOB',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Month/Date/Year',
        builder: (context ,child){
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: mainColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: mainColor,
                ),
              )
            ), child: child!,
          );
        }
        );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }


  completeUserInfo({
    String? name,
    File? image,
    String? gender,
    String? birthDay,
    String? medicalProf,
  }) async {
     String downloadUrl =  await _uploadToStorage(image!);
    userCollection.doc(user!.uid).update({
      'name':name,
      'gender':gender,
      'profilePic':downloadUrl,
      'medicalProf':medicalProf,
      'birthDay':birthDay,
    });
    isGotoComInfo=true;
    authBox.write("completeInfo", isGotoComInfo);
    update();
  }


  updateName(name){
    FirebaseFirestore.instance.collection('users')
        .doc(auth.currentUser!.uid)
        .update({
      "name":name,

    });
  update();
  }
  updateMedicalProfile(medicalProfile){

    FirebaseFirestore.instance.collection('users')
        .doc(auth.currentUser!.uid)
        .update({

      "medicalProf":medicalProfile,
    });
  update();
  }
}
