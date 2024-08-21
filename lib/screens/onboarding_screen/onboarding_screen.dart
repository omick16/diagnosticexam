import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static List<PageViewModel> listPagesViewModel = <PageViewModel>[
    PageViewModel(
      decoration: const PageDecoration(
        imageFlex: 3,
        fullScreen: false,
        imagePadding: EdgeInsets.only(top: 50),
      ),
      title: "Start Building Positive Habits Today!",
      body: "Track your habits effortlessly and make progress every day.",
      image: Center(
        child: Image.asset('assets/images/slide1.png'),
      ),
    ),
    PageViewModel(
      decoration: const PageDecoration(
        imageFlex: 3,
        fullScreen: false,
        imagePadding: EdgeInsets.all(20.0),
      ),
      title: "Stay on Track, Every Day!",
      body: "Stay focused and achieve your goals with daily habit reminders.",
      image: Center(
        child: Image.asset('assets/images/slide2.png'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        onDone: () {
          Get.offAllNamed('/home');
        },
        onSkip: () {
          Get.offAllNamed('/home');
          // You can also override onSkip callback
        },
        // globalBackgroundColor: kBackground,
        showSkipButton: true,

        skip: const Text("Skip"),
        next: const Text("Next"),

        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: Theme.of(context).colorScheme.primary,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
