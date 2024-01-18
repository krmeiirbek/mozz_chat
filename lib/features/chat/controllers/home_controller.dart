import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/chat/chat_repository.dart';
import 'package:mozz_chat/data/repositories/user/user_repository.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';
import 'package:mozz_chat/utils/popups/loaders.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final chatRepo = Get.put(ChatRepository());


  Future<List<UserModel>> getUsers() async {
    try {
      return await chatRepo.getAllUsers();
    } catch (e) {
      TLoaders.customToast(message: e.toString());
      return [];
    }
  }

  Future<List<ChatModel>> getChats() async {
    try {
      final user = await UserRepository.instance.fetchUserDetails();
      return await chatRepo.getAllChats(user);
    } catch (e) {
      print(e.toString());
      TLoaders.customToast(message: e.toString());
      return [];
    }
  }
}
