import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.splashPath,
      key: ValueKey(AppPages.splashPath),
      child: SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/avocado_man.png'),
                ),
              ),
              const Spacer(),
              const Text(
                'AI.Vocate 1.0.0',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
