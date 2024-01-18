import 'package:flutter/material.dart';
import 'package:mozz_chat/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:mozz_chat/features/chat/controllers/home_controller.dart';

class AppBarWithSearch extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithSearch({
    super.key,
    required this.title,
    this.height = 169,
  });

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: height,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Color(0xff2B333E)),
              ),
              IconButton(onPressed: () => HomeController.instance.logout(), icon: const Icon(Icons.logout, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 6),
          const TSearchContainer(text: 'Поиск')
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
