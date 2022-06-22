import 'package:flutter/material.dart';
import 'package:riderhub/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final bool isEnglish;
  const ChatScreen({Key key, this.isEnglish}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chats = [];
  var selectedChat = 0;

  @override
  void initState() {
    super.initState();

    chats.add(ChatModel());
    chats.add(ChatModel());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var chat in chats)
            InkWell(
              child: chat.itemWidget(
                  isOpened: selectedChat == chats.indexOf(chat), isEnglish: widget.isEnglish),
              onTap: () {
                setState(() {
                  selectedChat = chats.indexOf(chat);
                });
              },
            ),
        ],
      ),
    );
  }
}
