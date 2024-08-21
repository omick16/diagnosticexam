import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/login_controller.dart';
import 'package:go_habits/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: VShapeClipper(),
                child: Container(
                  height: 600,
                  color: Colors.pink,
                  child: Image.asset(
                    'assets/images/front.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: 50,
                height: 50,
                child: Image.asset('assets/images/panda.png'),
              ),
            ],
          ),
          Text("HabitsGo", style: AppTextStyle.companyName),
          Text("Craft your dream life.", style: AppTextStyle.companySubtitle),
          const Spacer(flex: 3),
          ElevatedButton.icon(
            icon: Image.asset('assets/images/google.png', height: 24.0),
            onPressed: () {
              Get.find<LoginController>().signInWithGoogle();
            },
            label: const Text("Sign in with Google"),
          ),
          const SizedBox(height: 10),
          Text("Terms and Condition", style: AppTextStyle.textLink),
          const Spacer(flex: 1)
        ],
      ),
    );
  }
}

class VShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 200);
    path.lineTo(size.width / 2, size.height - 20);
    path.lineTo(0, size.height - 200);
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
