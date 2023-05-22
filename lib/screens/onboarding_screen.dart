import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.onboardingPath,
      key: ValueKey(AppPages.onboardingPath),
      child: OnboardingScreen(),
    );
  }

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 150,
        title: const Image(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/avocado_man.png'),
        ),
      ),
      body: SafeArea(
        child: IntroductionScreen(
          done: const Text("Done"),
          skip: const Text("Skip"),
          next: const Text("Next"),
          // back: const Text("Back"),
          onDone: () {
            Provider.of<AppStateManager>(context, listen: false)
                .setOnboardingPassed();
          },
          showNextButton: true,
          showBackButton: false,
          showSkipButton: true,
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          // dotsContainerDecorator: const ShapeDecoration(
          //   color: Colors.black87,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
          //   ),
          // ),
          pages: [
            PageViewModel(
              title: '',
              bodyWidget: const Text(
                'Useful instructions 1',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            PageViewModel(
              title: '',
              bodyWidget: const Text(
                'Useful instructions 2',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            PageViewModel(
              title: '',
              bodyWidget: const Text(
                'Useful instructions 3',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            PageViewModel(
              title: '',
              bodyWidget: const Text(
                'Useful instructions 4',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
