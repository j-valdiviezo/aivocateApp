import 'package:ai_vocate/models/chat.dart';
import 'package:flutter/material.dart';

class ChatsManager with ChangeNotifier {
  Chat? _selectedChat;
  Chat? get selectedChat => _selectedChat;

  Future<void> selectChat(Chat chat) async {
    _selectedChat = chat;
    notifyListeners();
  }

  Future<void> deselectChat() async {
    _selectedChat = null;
    notifyListeners();
  }
}
