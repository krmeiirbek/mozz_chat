import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/features/chat/models/message.dart';
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

  Stream<List<MessageModel>> getMessages(String chatId) {
    try {
      return _db.collection('Chats').doc(chatId).snapshots().map((snapshot) {
        if (snapshot.exists) {
          ChatModel chatModel = ChatModel.fromSnapshot(snapshot);
          return chatModel.messages;
        } else {
          return [];
        }
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ChatModel> createChat(UserModel currentUserModel, UserModel userModel) async {
    try {
      final snapshot = await _db.collection('Chats').where('users', arrayContains: currentUserModel.toJson()).get();
      print(snapshot.docs.length);

      final existingChats = snapshot.docs.map((doc) => ChatModel.fromSnapshot(doc));

      final ffff = existingChats.where((element) => element.users.where((element2) => element2.id == userModel.id).first.name == userModel.name);

      if (ffff.isNotEmpty) {
        return ffff.first;
      } else {
        var newChat = ChatModel(id: '', users: [currentUserModel, userModel], messages: []);
        final docNewChat = _db.collection('Chats').doc();
        newChat.id = docNewChat.id;
        await docNewChat.set(newChat.toJson());
        return newChat;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addMessage(String chatId, MessageModel messageModel) async {
    try {
      await _db.collection('Chats').doc(chatId).update({
        'messages': FieldValue.arrayUnion([messageModel.toFirebase()]),
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
