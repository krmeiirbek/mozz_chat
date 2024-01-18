import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mozz_chat/features/welcome/screens/login/login.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();


  void logout() {
    GetStorage().remove('uid');
    Get.offAll(() => const LoginScreen());
  }

}