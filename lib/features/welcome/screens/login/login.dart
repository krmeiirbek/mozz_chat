import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/features/welcome/controllers/login_controller.dart';
import 'package:mozz_chat/utils/validators/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  validator: (value) => TValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(hintText: 'Give Your Name'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.login(),
                  child: const Text('Open Chat'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
