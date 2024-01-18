import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/common/widgets/images/t_circular_image.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/features/welcome/controllers/login_controller.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: GestureDetector(
            onTap: controller.signInWithGoogle,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
                color: Colors.white,
              ),
              child: Obx(() {
                if (LoginRepository.instance.loading.value) {
                  return const Center(child: CupertinoActivityIndicator(color: Colors.white));
                } else {
                  return Row(
                    children: [
                      const SizedBox(width: TSizes.spaceBtwItems),
                      const TCircularImage(image: MozzImages.google),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Text(
                        'Google-мен кіру',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
