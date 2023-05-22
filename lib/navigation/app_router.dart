import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:ai_vocate/providers/app_state_manager.dart';
import 'package:ai_vocate/providers/chats_manager.dart';
import 'package:ai_vocate/screens/chat_screen.dart';
import 'package:ai_vocate/screens/email_enter_screen.dart';
import 'package:ai_vocate/screens/email_verify_screen.dart';
import 'package:ai_vocate/screens/home.dart';
import 'package:ai_vocate/screens/onboarding_screen.dart';
import 'package:ai_vocate/screens/registration_form_screen.dart';
import 'package:ai_vocate/screens/sign_in_choice_screen.dart';
import 'package:ai_vocate/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter extends RouterDelegate<dynamic>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final HeroController heroController = HeroController();

  final AppStateManager appStateManager;
  final ChatsManager chatsManager;

  AppRouter({
    required this.appStateManager,
    required this.chatsManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    chatsManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    chatsManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isOnboardingPassed) ...[
          OnboardingScreen.page(),
        ] else if (!appStateManager.isAuthenticated) ...[
          SignInChoiceScreen.page(),
          if (appStateManager.selectedAuthPage == AuthPages.emailEnterPath ||
              appStateManager.selectedAuthPage ==
                  AuthPages.emailVerifyPath) ...[EmailEnterScreen.page()],
          if (appStateManager.selectedAuthPage ==
              AuthPages.emailVerifyPath) ...[EmailVerifyScreen.page()],
        ] else if (!(appStateManager.user == null) &&
            appStateManager.user!.isNew) ...[
          RegistrationFormScreen.page(),
        ] else ...[
          Home.page(appStateManager.selectedHomeTab),
          if (appStateManager.selectedAuthPage == AuthPages.emailEnterPath ||
              appStateManager.selectedAuthPage ==
                  AuthPages.emailVerifyPath) ...[
            EmailEnterScreen.page(),
          ],
          if (appStateManager.selectedAuthPage ==
              AuthPages.emailVerifyPath) ...[
            EmailVerifyScreen.page(),
          ],
          if (chatsManager.selectedChat != null) ...[
            ChatScreen.page(chatsManager.selectedChat!),
          ],
        ],
      ],
      observers: [heroController],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == AuthPages.emailEnterPath) {
      appStateManager.exitSignInWithEmail();
      return true;
    }

    if (route.settings.name == AuthPages.emailVerifyPath) {
      appStateManager.exitEmailVerification();
      return true;
    }

    if (route.settings.name == AppPages.chat) {
      chatsManager.deselectChat();
      return true;
    }

    return true;
  }

  @override
  // ignore: avoid_returning_null_for_void
  Future<void> setNewRoutePath(configuration) async => null;
}
