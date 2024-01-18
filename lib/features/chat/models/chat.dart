import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozz_chat/features/chat/models/message.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';

class ChatModel {
  final String id;
  final List<UserModel> users;
  final List<MessageModel> messages;

  ChatModel({required this.id, required this.users, required this.messages});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users': users.map((user) => user.toJson()).toList(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      users: (json['users'] as List<dynamic>).map((userJson) => UserModel.fromJson(userJson)).toList(),
      messages: (json['messages'] as List<dynamic>).map((messageJson) => MessageModel.fromJson(messageJson)).toList(),
    );
  }

  factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    print('chat');
    return ChatModel(
      id: snapshot.id,
      users: (data['users'] as List<dynamic>).map((userJson) => UserModel.fromJson(userJson)).toList(),
      messages: (data['messages'] as List<dynamic>).map((messageJson) => MessageModel.fromJson(messageJson)).toList(),
    );
  }
}
