import 'package:get/get.dart';
import 'package:mozz_chat/features/chat/screens/home/home.dart';
import 'package:mozz_chat/features/welcome/screens/login/login.dart';

import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    // GetPage(name: TRoutes.chat, page: () => const Chat()),
  ];
}