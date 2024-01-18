import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LoginRepository extends GetxController {
  static LoginRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


}
