import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/user/user_repository.dart';
import 'package:mozz_chat/features/welcome/controllers/login_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository());
    Get.put(LoginController());
  }
}
