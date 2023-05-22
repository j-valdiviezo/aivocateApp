import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationFormScreen extends StatelessWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AuthPages.registrationFormPath,
      key: ValueKey(AuthPages.registrationFormPath),
      child: RegistrationFormScreen(),
    );
  }

  const RegistrationFormScreen({Key? key}) : super(key: key);

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
          title: const Text('Registration form'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'We are learning who might need AI.Vocate the most. Please fill out the short form below to continue.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sex',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      //TODO: form validation, etc.
                      // appStateManager.signIn('code');
                      appStateManager.submitRegistrationForm('');
                    },
                    child: const Text(
                      'Finish registration',
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
