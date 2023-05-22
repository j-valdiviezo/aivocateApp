import 'package:ai_vocate/models/chat.dart';
import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/providers/chats_manager.dart';
import 'package:ai_vocate/screens/chats_screen.dart';
import 'package:ai_vocate/screens/faq_screen.dart';
import 'package:ai_vocate/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  final int currentTab;

  const BottomNavigation({super.key, required this.currentTab});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      backgroundColor: Colors.white,
      selectedIconTheme: const IconThemeData(size: 30),
      unselectedIconTheme: const IconThemeData(size: 30),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: widget.currentTab,
      onTap: (index) {
        if (index != widget.currentTab) {
          FocusManager.instance.primaryFocus?.unfocus();
          Provider.of<AppStateManager>(
            context,
            listen: false,
          ).goToHomeTab(index);
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: 'FAQ',
          icon: Icon(CupertinoIcons.question_circle),
        ),
        BottomNavigationBarItem(
          label: 'Chats',
          icon: Icon(CupertinoIcons.chat_bubble),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.home,
      key: const ValueKey(AppPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  static List<PreferredSizeWidget?> appBars = [
    null,
    AppBar(
      title: const Text('Chats'),
      key: const Key('Chats AppBar'),
      scrolledUnderElevation: 0.0,
    ),
    const ProfileScreenAppBar(),
  ];

  static List<Widget> pages = [
    const FaqScreen(),
    const ChatsScreen(),
    const ProfileScreen(),
  ];

  const Home({super.key, required this.currentTab});

  final int currentTab;

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: appBars[currentTab],
        body: Center(
          child: IndexedStack(
            index: currentTab,
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
        ),
        floatingActionButton: (currentTab == HomeTab.chats) &&
                !(appStateManager.user == null ||
                    !appStateManager.user!.isSubscribed)
            ? FloatingActionButton.extended(
                onPressed: () {
                  //TODO: Add new chat (only device)
                  final chatsManager = Provider.of<ChatsManager>(
                    context,
                    listen: false,
                  );
                  chatsManager.selectChat(const Chat(
                    name: 'Chat New',
                    messages: [],
                    isNew: true,
                  ));
                },
                label: const Text('New Chat'),
                icon: const Icon(Icons.add),
                autofocus: false,
                // child: Row(
                //   children: const [
                //     Text('New Chat'),
                //     Icon(Icons.add),
                //   ],
                // ),
              )
            : null,
      ),
    );
  }
}
