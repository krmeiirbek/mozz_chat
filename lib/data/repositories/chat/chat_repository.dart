import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _db.collection('Users').get();
      return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ChatModel>> getAllChats(UserModel userModel) async {
    try {
      final snapshot = await _db.collection('Chats').where('users', arrayContains: userModel.toJson()).get();
      return snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
