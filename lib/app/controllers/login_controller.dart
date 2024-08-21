import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn signIn = GoogleSignIn();
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(
      auth.authStateChanges(),
    ); //listen to all state changes of the user
    ever(_user, initialScreen); //triggers everytime there is a state change
    super.onInit();
  }

  void initialScreen(User? user) {
    if (user == null && Get.currentRoute != '/login') {
      Get.offAllNamed('/login');
    } else if (user != null && Get.currentRoute != '/onBoarding') {
      Get.offAllNamed('/onBoarding');
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await signIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        return await auth.signInWithCredential(credential);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in with google",
          backgroundColor: Colors.red);
    }
  }

  void signOut() async {
    await signIn.signOut();
    await auth.signOut();
    Get.offAllNamed('/login');
  }
}
