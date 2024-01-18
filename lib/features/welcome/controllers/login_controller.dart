import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mozz_chat/data/repositories/login/login_repository.dart';
import 'package:mozz_chat/data/repositories/user/user_repository.dart';
import 'package:mozz_chat/features/welcome/models/user_model.dart';
import 'package:mozz_chat/utils/constants/image_strings.dart';
import 'package:mozz_chat/utils/popups/full_screen_loader.dart';
import 'package:mozz_chat/utils/popups/loaders.dart';
import 'package:mozz_chat/utils/popups/show_dialogs.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final loginRepo = LoginRepository.instance;
  final userRepository = Get.put(UserRepository());

  void signInWithGoogle() async {
    if (loginRepo.loading.value) {
      return;
    }
    try {
      TFullScreenLoader.openLoadingDialog(
        "Жүктелуде...",
        MozzImages.loading,
      );

      final userCredentials = await loginRepo.signInWithGoogle();

      await saveUserRecord(userCredentials);

      TFullScreenLoader.stopLoading();

      loginRepo.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.customToast(
        message: e.toString(),
      );
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final user = UserModel(
          id: userCredentials.user!.uid,
          name: userCredentials.user!.displayName ?? '',
          image: userCredentials.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.customToast(
        message: "Ақпаратыңызды сақтау кезінде бірдеңе дұрыс болмады. "
            "Деректерді профильде қайта сақтауға болады",
      );
    }
  }

  void logoutAccount() {
    ShowDialogs.logoutShowDialog(
        title: "Шығу",
        onPressed: () async => loginRepo.logout(),
        middleText: "Есептік жазбадан шыққыңыз келетініне сенімдісіз бе?");
  }
}
