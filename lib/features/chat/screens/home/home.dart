import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/common/widgets/appbar/appbar_search.dart';
import 'package:mozz_chat/common/widgets/images/t_circular_image.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/features/chat/controllers/home_controller.dart';
import 'package:mozz_chat/features/chat/models/chat.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/constants/sizes.dart';
import 'package:mozz_chat/utils/helpers/cloud_helper_functions.dart';
import 'package:mozz_chat/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: const AppBarWithSearch(title: 'Чаты'),
      body: Container(
        padding: const EdgeInsets.all(TSizes.md),
        child: FutureBuilder<List<ChatModel>>(
            future: controller.getChats(),
            initialData: const [],
            builder: (context, snapshot) {
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) {
                return widget;
              }
              final chats = snapshot.data!;
              return ListView.separated(
                itemBuilder: (_, index) {
                  final chat = chats[index];
                  final secondUser = chat.users.where((element) => element.id != LoginRepository.instance.authUser!.uid).first;
                  chat.messages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
                  final lastMessage = chat.messages.isNotEmpty ? chat.messages.first : null;
                  return ListTile(
                    title: Text(secondUser.name),
                    leading: TCircularImage(
                      image: secondUser.image ?? MozzImages.google,
                      isNetworkImage: secondUser.image != null,
                    ),
                    subtitle: Text('${(lastMessage?.author ?? '') == secondUser.name ? '' : 'Вы: '}${lastMessage?.message ?? ''}'),
                    trailing: Text( lastMessage?.sendTime != null ?THelperFunctions.getFormattedDate(lastMessage!.sendTime) : ''),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: chats.length,
              );
            }),
      ),
    );
  }
}
