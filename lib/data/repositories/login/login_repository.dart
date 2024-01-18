import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mozz_chat/features/chat/screens/home/home.dart';
import 'package:mozz_chat/features/welcome/screens/login/login.dart';

class LoginRepository extends GetxController {
  static LoginRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final storage = GetStorage();
  final currentUser = ''.obs;

  @override
  void onReady() {
    screenRedirect();
    super.onReady();
  }

  void screenRedirect() async {
    final uid = storage.read<String>('uid');
    if (uid == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      currentUser.value = uid;
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<String> login(String userName) async {
    try {
      var user = _db.collection('Users').doc(userName);
      await user.set({'name': userName});
      storage.write('uid', user.id);
      currentUser.value = user.id;
      return user.id;
    } catch (e) {
      throw e.toString();
    }
  }
}
