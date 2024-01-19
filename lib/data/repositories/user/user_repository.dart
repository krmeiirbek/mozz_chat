import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      var userRef = _db.collection("Users").doc(user.id);
      var doc = await userRef.get();
      if (doc.exists) {
        return;
      }
      var userData = user.toJson();

      await _db.collection("Users").doc(user.id).set(userData);
    } catch (e) {
      throw 'Бірдеңе дұрыс болмады, қайталап көріңіз';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final uid = LoginRepository.instance.authUser?.uid;
      print(uid);
      final documentSnapshot = await _db.collection("Users").doc(uid).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw 'Бірдеңе дұрыс болмады, қайталап көріңіз';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } catch (e) {
      throw 'Бірдеңе дұрыс болмады, қайталап көріңіз';
    }
  }
}
