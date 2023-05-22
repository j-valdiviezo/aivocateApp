import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInWithEmailButton extends StatelessWidget {
  const SignInWithEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        appStateManager.chooseSignInWithEmail();
      },
      child: const Text(
        'Sign in with email',
      ),
    );
  }
}
