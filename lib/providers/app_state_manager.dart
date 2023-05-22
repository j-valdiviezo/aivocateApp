import 'dart:async';

import 'package:ai_vocate/models/user.dart';
import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomeTab {
  static const faq = 0;
  static const chats = 1;
  static const profile = 2;
}

class AppStateManager with ChangeNotifier {
  bool _initialized = false;
  bool _isOnboardingPassed = false;
  bool _internetConnection = true;
  bool _isAuthenticated = false;
  String _selectedAuthPage = AuthPages.signInChoicePath;
  String _authEmail = '';
  int _selectedHomeTab = HomeTab.faq;
  User? _user;

  bool get isInitialized => _initialized;
  bool get isOnboardingPassed => _isOnboardingPassed;
  bool get internetConnection => _internetConnection;
  bool get isAuthenticated => _isAuthenticated;
  String get selectedAuthPage => _selectedAuthPage;
  String get authEmail => _authEmail;
  int get selectedHomeTab => _selectedHomeTab;
  User? get user => _user;

  AppStateManager() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none ||
          result == ConnectivityResult.bluetooth) {
        _internetConnection = false;
      }
      _internetConnection = true;
      notifyListeners();
    });
  }

  Future<void> initializeApp() async {
    // SETUP ALL SERVICES FOR WORK
    // await initHiveForFlutter();
    // await Services.storage.initialize();
    // final accessToken = await Services.storage.getAccessToken();
    // final refreshToken = await Services.storage.getRefreshToken();
    // await Services.api.initialize(AuthData(accessToken, refreshToken));

    // CHECK AUTH

    Future.delayed(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  Future<void> setOnboardingPassed() async {
    //TODO: store onboarding passed
    _isOnboardingPassed = true;
    notifyListeners();
  }

  Future<void> chooseSignInWithEmail() async {
    _selectedAuthPage = AuthPages.emailEnterPath;
    notifyListeners();
  }

  Future<void> exitSignInWithEmail() async {
    _selectedAuthPage = AuthPages.signInChoicePath;
    notifyListeners();
  }

  Future<void> sendEmailVerification(String email) async {
    //TODO: store email, send verification
    _selectedAuthPage = AuthPages.emailVerifyPath;
    _authEmail = email;
    notifyListeners();
  }

  Future<void> exitEmailVerification() async {
    _selectedAuthPage = AuthPages.emailEnterPath;
    notifyListeners();
  }

  Future<void> signIn(String code) async {
    //TODO: send code, get user
    _user = const User(isNew: true, isSubscribed: false);
    _isAuthenticated = true;
    _selectedAuthPage = AuthPages.signInChoicePath;
    notifyListeners();
  }

  Future<void> submitRegistrationForm(dynamic form) async {
    //TODO: send form, get new user, etc.
    _user = const User(isNew: false, isSubscribed: false);
    notifyListeners();
  }

  Future<void> subscribe() async {
    //TODO: send payment, get new user, etc.
    _user = const User(isNew: false, isSubscribed: true);
    notifyListeners();
  }

  Future<void> signInAsGuest() async {
    _isAuthenticated = true;
    _selectedAuthPage = AuthPages.signInChoicePath;
    notifyListeners();
  }

  Future<void> signOut() async {
    //TODO: delete tokens, etc.
    _isAuthenticated = false;
    _user = null;
    _selectedHomeTab = HomeTab.faq;
    notifyListeners();
  }

  Future<void> goToHomeTab(int tab) async {
    _selectedHomeTab = tab;
    notifyListeners();
  }
}
