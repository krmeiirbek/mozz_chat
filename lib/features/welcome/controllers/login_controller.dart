import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final nameController = TextEditingController();



  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}