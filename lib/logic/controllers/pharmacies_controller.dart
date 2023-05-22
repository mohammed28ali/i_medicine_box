import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/pharmacy_model.dart';

class PharmaciesController extends GetxController{
  var isLoading=false;
  var pharmaciesList=<PharmaciesModel>[];
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList<PharmaciesModel> pharmacies=RxList<PharmaciesModel>([]);

  @override
  void onInit(){
    super.onInit();
    collectionReference=firestore.collection("pharmacies");
    pharmacies.bindStream(getAllPharmacies());
  }

  Stream<List<PharmaciesModel>>getAllPharmacies()=>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => PharmaciesModel.fromMap(item)).toList());




  Future<void> launchURL(String url) async {
    final uri = Uri.https('goo.gl',url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

}
