import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailEnterScreen extends StatefulWidget {
  static MaterialPage page() {
    return const MaterialPage(
      name: AuthPages.emailEnterPath,
      key: ValueKey(AuthPages.emailEnterPath),
      child: EmailEnterScreen(),
    );
  }

  const EmailEnterScreen({Key? key}) : super(key: key);

  @override
  State<EmailEnterScreen> createState() => _EmailEnterScreenState();
}

class _EmailEnterScreenState extends State<EmailEnterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';

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
          title: const Text('Sign in with email'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    const Text(
                      'Enter your email below to receive authorization code.',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue ?? '';
                      },
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          appStateManager.sendEmailVerification(email);
                        }
                      },
                      child: const Text(
                        'Receive code',
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
