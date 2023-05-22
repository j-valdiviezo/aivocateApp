import 'package:ai_vocate/models/chat.dart';
import 'package:ai_vocate/navigation/app_pages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static MaterialPage page(Chat chat) {
    return MaterialPage(
      name: AppPages.chat,
      key: const ValueKey(AppPages.chat),
      child: ChatScreen(
        chat: chat,
      ),
    );
  }

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _didAnswer = false;
  static const otherAnswer = 'I am sorry, I do not understand.';
  static const replies = {
    'yes': 'Fantastic! I am asking questions... [ERROR!!!]',
    'no': 'I am sorry to hear that. Not gonna ask you anything then.',
  };

  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  List<Message> _messages = [];
  String _message = '';

  @override
  void initState() {
    super.initState();
    _messages = widget.chat.messages.map((e) => e).toList();
  }

  @override
  Widget build(BuildContext context) {
    final coolContext = context;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        extendBody: false,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(widget.chat.name),
        ),
        body: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              if (!widget.chat.isNew) ...[
                Expanded(
                  child: ListView.separated(
                    reverse: true,
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 150),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: _messages.reversed.toList()[index].isFromMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _messages.reversed.toList()[index].isFromMe
                                ? Colors.blueGrey[100]
                                : Colors.green[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _messages.reversed.toList()[index].text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                      // return ListTile(
                      //   contentPadding: const EdgeInsets.symmetric(
                      //     horizontal: 20,
                      //   ),
                      //   title: Text('Vow, how are you? $index'),
                      //   trailing: Text('1$index:00'),
                      // );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                ),
              ] else ...[
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Do you have a question about US laws? Visa, immigration, citizenship, or anything else? Ask us!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                // Account for bottom sheet
                const SizedBox(height: 100),
              ],
            ],
          ),
        ),
        bottomSheet: SafeArea(
          child: BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10 + MediaQuery.of(coolContext).padding.bottom,
                ),
                child: TextField(
                  controller: _inputController,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        if (mounted && _scrollController.hasClients) {
                          _scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    );
                  },
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 100,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Message',
                    suffixIcon: _message.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              if (mounted && _scrollController.hasClients) {
                                _scrollController
                                    .animateTo(
                                  0.0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                )
                                    .then((value) {
                                  setState(() {
                                    _messages.add(Message(
                                      text: _message,
                                      isFromMe: true,
                                    ));
                                  });
                                  _inputController.clear();
                                });
                              }

                              Future.delayed(const Duration(seconds: 2), () {
                                if (!_didAnswer &&
                                    _message.toLowerCase().contains('yes')) {
                                  setState(() {
                                    _messages.add(Message(
                                      text: replies['yes']!,
                                      isFromMe: false,
                                    ));
                                  });
                                  _didAnswer = true;
                                  return;
                                }

                                if (!_didAnswer &&
                                    _message.toLowerCase().contains('no')) {
                                  setState(() {
                                    _messages.add(Message(
                                      text: replies['no']!,
                                      isFromMe: false,
                                    ));
                                  });
                                  _didAnswer = true;
                                  return;
                                }

                                setState(() {
                                  _messages.add(const Message(
                                    text: otherAnswer,
                                    isFromMe: false,
                                  ));
                                });
                              });
                            },
                            icon: const Icon(Icons.send),
                          )
                        : null,
                    // prefixIcon: IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.attach_file),
                    // ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _message = value;
                    });
                  },
                  // textInputAction: TextInputAction.send,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
