import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/common/widgets/images/t_circular_image.dart';
import 'package:mozz_chat/features/chat/controllers/chat_controller.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/features/chat/models/message.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/helpers/cloud_helper_functions.dart';
import 'package:mozz_chat/utils/helpers/helper_functions.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatModel, required this.userModel});

  final ChatModel chatModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    var messages = chatModel.messages;
    messages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(userModel.name),
          leading: TCircularImage(
            image: userModel.image ?? MozzImages.google,
            isNetworkImage: userModel.image != null,
          ),
          subtitle: const Text('Online'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => StreamBuilder<List<MessageModel>>(
                  key: Key(controller.loading.value.toString()),
                  stream: controller.getMessages(chatModel.id),
                  initialData: messages,
                  builder: (context, snapshot) {
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (widget != null) {
                      return widget;
                    }
                    final messages = snapshot.data!;
                    messages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (_, index) {
                                final message = messages[index];
                                return Column(
                                  children: [
                                    if (controller.checkDay(index, messages.map((e) => e.sendTime).toList()))
                                      Row(
                                        children: [
                                          const Expanded(child: Divider(height: 2, color: Color(0xffEDF2F6))),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(
                                              THelperFunctions.getFormattedDay(message.sendTime),
                                              style: const TextStyle(color: Color(0xff9DB7CB), fontSize: 13, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const Expanded(child: Divider(height: 2, color: Color(0xffEDF2F6))),
                                        ],
                                      ),
                                    if (controller.checkDay(index, messages.map((e) => e.sendTime).toList())) const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: userModel.name == message.author ? MainAxisAlignment.start : MainAxisAlignment.end,
                                      children: [
                                        userModel.name == message.author
                                            ? Container(
                                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                                                  color: Color(0xffEDF2F6),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      message.message,
                                                      style: const TextStyle(color: Color(0xff00521C), fontSize: 14, fontWeight: FontWeight.w500),
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Text(
                                                      THelperFunctions.getFormattedTime(message.sendTime),
                                                      style: const TextStyle(color: Color(0xff00521C), fontSize: 10, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                                  color: Color(0xff3CED78),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      message.message,
                                                      style: const TextStyle(color: Color(0xff00521C), fontSize: 14, fontWeight: FontWeight.w500),
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Text(
                                                      THelperFunctions.getFormattedTime(message.sendTime),
                                                      style: const TextStyle(color: Color(0xff00521C), fontSize: 10, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                );
                              },
                            ),
                          ),
                          if (controller.sending.value)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                color: Color(0xff3CED78),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    controller.textController.text.trim(),
                                    style: const TextStyle(color: Color(0xff00521C), fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 7),
                                  SvgPicture.asset(
                                    MozzImages.union,
                                    color: const Color(0xff00521C),
                                    height: 7,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 100,
              color: const Color(0xffffffff),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(color: const Color(0xffEDF2F6), borderRadius: BorderRadius.circular(12)),
                    child: SvgPicture.asset(
                      MozzImages.attach,
                      color: const Color(0xff9DB7CB),
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        hintText: 'Сообщение',
                        hintStyle: const TextStyle(color: Color(0xff9DB7CB), fontSize: 16, fontWeight: FontWeight.w500),
                        fillColor: const Color(0xffEDF2F6),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => controller.sendMessage(chatModel.id),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(color: const Color(0xffEDF2F6), borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(
                        MozzImages.message_arrow,
                        color: const Color(0xff9DB7CB),
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
