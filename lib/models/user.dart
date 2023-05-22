import 'package:flutter/material.dart';

@immutable
class User {
  final bool isNew;
  final bool isSubscribed;

  const User({
    required this.isNew,
    required this.isSubscribed,
  });
}
