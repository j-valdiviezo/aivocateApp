import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/widgets/sign_in_with_email_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInChoiceScreen extends StatelessWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AuthPages.signInChoicePath,
      key: ValueKey(AuthPages.signInChoicePath),
      child: SignInChoiceScreen(),
    );
  }

  const SignInChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                const Text(
                  'Welcome to AI.Vocate! The revolutionary law guide app.',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose sign in option.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 3,
                ),
                const SignInWithEmailButton(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    appStateManager.signInAsGuest();
                  },
                  child: const Text(
                    'Continue as guest',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
