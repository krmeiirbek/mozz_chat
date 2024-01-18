import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/chat/chat_repository.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/features/chat/models/message.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final textController = TextEditingController();
  final loading = true.obs;
  final sending = false.obs;
  final chatRepo = ChatRepository.instance;

  Stream<List<MessageModel>> getMessages(String chatId) {
      return chatRepo.getMessages(chatId);

  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  bool checkDay(int index, List<DateTime> times) {
    if (index == times.length - 1) {
      return true;
    }

    DateTime current = times[index];
    DateTime next = times[index + 1];

    bool isNewDay = current.day != next.day || current.isBefore(next);

    return isNewDay;
  }

  Future<void> sendMessage(String chatId) async {
    if (textController.text.trim() == '') return;
    sending.value = true;
    await chatRepo.addMessage(
      chatId,
      MessageModel(
        message: textController.text.trim(),
        author: LoginRepository.instance.authUser?.displayName ?? '',
        sendTime: DateTime.now(),
      ),
    );
    textController.text = '';
    sending.value = false;
    loading.refresh();
  }
}
