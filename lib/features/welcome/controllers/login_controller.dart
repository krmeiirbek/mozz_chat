import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final loginRepo = Get.put(LoginRepository());
  final nameController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    try {
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      await loginRepo.login(nameController.text.trim());
      loginRepo.screenRedirect();
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
