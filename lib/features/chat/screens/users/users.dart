import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/common/widgets/images/t_circular_image.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/features/chat/controllers/home_controller.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/constants/sizes.dart';
import 'package:mozz_chat/utils/helpers/cloud_helper_functions.dart';

class UsersScreen extends GetView<HomeController> {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Container(
        padding: const EdgeInsets.all(TSizes.md),
        child: FutureBuilder<List<UserModel>>(
            future: controller.getUsers(),
            initialData: const [],
            builder: (context, snapshot) {
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) {
                return widget;
              }
              final users = snapshot.data!;
              users.removeWhere((e) => e.name == (LoginRepository.instance.authUser?.displayName ?? ''));
              return ListView.separated(
                itemBuilder: (_, index) {
                  final user = users[index];
                  return InkWell(
                    onTap: () => controller.createChat(user),
                    child: ListTile(
                      title: Text(user.name),
                      leading: TCircularImage(
                        image: user.image ?? MozzImages.google,
                        isNetworkImage: user.image != null,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: users.length,
              );
            }),
      ),
    );
  }
}
