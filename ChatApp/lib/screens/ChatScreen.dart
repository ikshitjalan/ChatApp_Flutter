import 'package:flutter/material.dart';

import '../models/Users.dart';
import '../models/Global.dart';
import '../models/ChatMessageModel.dart';

import '../widgets/ChatTitle.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/Chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessageModel> _chatMessages;
  User _toChatUser;
  UserOnlineStatus _userOnlineStatus;

  @override
  void initState() {
    super.initState();
    _chatMessages = List();
    _toChatUser = G.toChatUser;
    _userOnlineStatus = UserOnlineStatus.connecting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          toChatUser: _toChatUser,
          userOnlineStatus: _userOnlineStatus,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  ChatMessageModel chatMessage = _chatMessages[index];
                  return Text(
                    chatMessage.message,
                  );
                },
              ),
            ),
            _bottomChatArea(),
          ],
        ),
      ),
    );
  }

  _bottomChatArea() {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            _chatTextArea(),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: null,
            ),
          ],
        ));
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Type message',
        ),
      ),
    );
  }
}
