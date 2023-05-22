import 'package:flutter/material.dart';

@immutable
class Message {
  final String text;
  final bool isFromMe;

  const Message({
    required this.text,
    required this.isFromMe,
  });
}

@immutable
class Chat {
  //TODO: other type
  final String name;
  final List<Message> messages;
  final bool isNew;

  const Chat({
    required this.name,
    required this.messages,
    this.isNew = false,
  });
}
