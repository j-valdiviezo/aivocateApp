import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerifyScreen extends StatelessWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AuthPages.emailVerifyPath,
      key: ValueKey(AuthPages.emailVerifyPath),
      child: EmailVerifyScreen(),
    );
  }

  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Verify email'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Text(
                    'We sent you a code to\n${appStateManager.authEmail}',
                    style: const TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please check "Inbox" and "Spam" folders. Enter the code below to continue.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      //TODO: use code from input, code verification, etc.
                      appStateManager.signIn('code');
                    },
                    child: const Text(
                      'Sign in',
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
