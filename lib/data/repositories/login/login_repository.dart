import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mozz_chat/data/repositories/user/user_repository.dart';
import 'package:mozz_chat/features/chat/screens/home/home.dart';
import 'package:mozz_chat/features/welcome/screens/login/login.dart';

class LoginRepository extends GetxController {
  static LoginRepository get instance => Get.find();

  final currentUser = ''.obs;
  final _auth = FirebaseAuth.instance;
  final loading = false.obs;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    screenRedirect();
    super.onReady();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    loading.value = true;
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      return null;
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw 'Бірдеңе дұрыс болмады, қайталап көріңіз';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } catch (e) {
      throw 'Бірдеңе дұрыс болмады, қайталап көріңіз';
    }
  }
}
