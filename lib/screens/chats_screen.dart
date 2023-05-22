import 'package:ai_vocate/models/chat.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/providers/chats_manager.dart';
import 'package:ai_vocate/widgets/sign_in_with_email_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return Padding(
      padding:
          (appStateManager.user == null || !appStateManager.user!.isSubscribed)
              ? const EdgeInsets.symmetric(horizontal: 20)
              : EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (appStateManager.user == null) ...[
            const Center(
              child: Text(
                'You are viewing AI.Vocate app as guest. Please sign in to unlock chats.',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const SignInWithEmailButton(),
          ] else if (!appStateManager.user!.isSubscribed) ...[
            const Center(
              child: Text(
                'Subscribe to unlock the power of AI.',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                //TODO: add demo modal bottom sheet
                appStateManager.subscribe();
              },
              child: const Text(
                'Subscribe',
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    title: Text('Chat $index'),
                    subtitle: const Text('Last message'),
                    trailing: Text('1$index:00'),
                    onTap: () {
                      final chatsManager = Provider.of<ChatsManager>(
                        context,
                        listen: false,
                      );
                      chatsManager.selectChat(Chat(
                        name: 'Chat $index',
                        messages: const [
                          Message(
                            text: 'I need help with my taxes!',
                            isFromMe: true,
                          ),
                          Message(
                            text:
                                'Sure, I can help you with that. What is your question?',
                            isFromMe: false,
                          ),
                          Message(
                            text: 'Can I not pay taxes this year please?',
                            isFromMe: true,
                          ),
                          Message(
                            text: 'I am sorry, but that is not possible.',
                            isFromMe: false,
                          ),
                          Message(
                            text: 'Okey, sad😭',
                            isFromMe: true,
                          ),
                          Message(
                            text:
                                "Don't worry! There's always a way to pay less taxes. "
                                "I can help you with that. I will need to ask you a few questions to get started. Are you ready?",
                            isFromMe: false,
                          ),
                        ],
                      ));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       border: const OutlineInputBorder(),
            //       labelText: 'Message',
            //       suffixIcon: IconButton(
            //         onPressed: () {},
            //         icon: const Icon(Icons.send),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
