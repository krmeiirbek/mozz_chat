import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/chat/chat_repository.dart';
import 'package:mozz_chat/data/repositories/user/user_repository.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/features/chat/screens/chat/chat.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/popups/full_screen_loader.dart';
import 'package:mozz_chat/utils/popups/loaders.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final chatRepo = Get.put(ChatRepository());
  final loading = true.obs;

  Future<List<UserModel>> getUsers() async {
    try {
      return await chatRepo.getAllUsers();
    } catch (e) {
      TLoaders.customToast(message: e.toString());
      return [];
    }
  }

  Stream<List<ChatModel>> getChats() async* {
    try {
      final user = await UserRepository.instance.fetchUserDetails();
      final List<ChatModel> chats = await chatRepo.getAllChats(user);
      yield chats; // Emit the initial list of chats

      // Listen for changes in the 'Chats' collection and update the stream accordingly
      await for (List<ChatModel> updatedChats in FirebaseFirestore.instance.collection('Chats').snapshots().asyncMap((snapshot) async {
        final List<ChatModel> chats = await chatRepo.getAllChats(user);
        return chats;
      })) {
        yield updatedChats; // Emit the updated list of chats
      }
    } catch (e) {
      TLoaders.customToast(message: e.toString());
    }
  }

  Future<void> createChat(UserModel userModel) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        "Жүктелуде...",
        MozzImages.loading,
      );
      final currentUserModel = await UserRepository.instance.fetchUserDetails();
      final newChat = await chatRepo.createChat(currentUserModel, userModel);
      TFullScreenLoader.stopLoading();
      Get.off(() => ChatScreen(chatModel: newChat, userModel: userModel));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.customToast(message: e.toString());
    }
  }
}
