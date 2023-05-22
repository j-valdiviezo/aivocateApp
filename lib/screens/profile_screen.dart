import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/widgets/sign_in_with_email_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              title: const Text('User ID'),
              subtitle: Text(appStateManager.user.hashCode.toString()),
              trailing: const Icon(Icons.copy, color: Colors.black),
              onTap: () {
                final messenger = ScaffoldMessenger.of(context);
                Clipboard.setData(
                  ClipboardData(
                    text: appStateManager.user.hashCode.toString(),
                  ),
                );
                messenger.showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'User ID copied to clipboard',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // minimumSize: const Size(0, 0),
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                appStateManager.signOut();
              },
              child: const Center(
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(0, 0),
                foregroundColor: Colors.grey,
              ),
              onPressed: () {
                // TODO: add account delete dialog
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return const AccountDeleteDialog();
                //   },
                // );
              },
              child: const Text(
                'Delete account',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return AppBar(
      key: const Key('Profile AppBar'),
      title: const Text('Profile'),
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      actions: [
        if (appStateManager.user != null)
          Center(
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.grey[50],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    // SCAFFOLD IS USED TO SHOW SNACKBAR PROPERLY. MORE HERE: https://github.com/flutter/flutter/issues/80934
                    return const Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: ProfileBottomSheet(),
                    );
                  },
                );
              },
              iconSize: 30,
              icon: const Icon(Icons.menu),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (appStateManager.user == null) ...[
            const Center(
              child: Text(
                'You are viewing AI.Vocate app as guest. Please sign in to unlock more features.',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const SignInWithEmailButton(),
          ] else ...[
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'email',
              ),
              initialValue: '{example@gmail.com}',
            ),
            TextFormField(
              // KEY CHANGES => INITIAL VALUE CHANGES
              key: Key('Sub: ${appStateManager.user!.isSubscribed}'),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'subscription',
              ),
              initialValue: appStateManager.user!.isSubscribed
                  ? 'active until {date}'
                  : 'inactive',
            ),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'First name',
              ),
              initialValue: '{first name}',
            ),
            const Spacer(),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     foregroundColor: Colors.red,
            //   ),
            //   onPressed: () {
            //     appStateManager.signOut();
            //   },
            //   child: const Text(
            //     'Sign out',
            //     style: TextStyle(color: Colors.redAccent),
            //   ),
            // ),
          ],
        ],
      ),
    );
  }
}
