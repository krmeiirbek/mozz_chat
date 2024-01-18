import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String author;
  final DateTime sendTime;

  MessageModel({required this.message, required this.author, required this.sendTime});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'author': author,
      'sendTime': sendTime.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      author: json['author'],
      sendTime: (json['sendTime'] as Timestamp).toDate(),
    );
  }

  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    print('message1');
    final data = snapshot.data() as Map<String, dynamic>;
    print('message2');
    return MessageModel(
      message: data['message'],
      author: data['author'],
      sendTime: (data['sendTime'] as Timestamp).toDate(),
    );
  }
}
