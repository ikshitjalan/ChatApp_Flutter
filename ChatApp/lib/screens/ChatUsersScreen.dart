import 'package:flutter/material.dart';

import '../models/Users.dart';
import '../models/Global.dart';

import '../screens/ChatScreen.dart';
import '../screens/LoginScreen.dart';

class ChatUsersScreen extends StatefulWidget {
  static const routeName = '/ChatUsers';
  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  List<User> _chatUsers;

  @override
  void initState() {
    super.initState();
    _chatUsers = G.getUsersFor(
      G.loggedInUser,
    );
  }

  _openChatScreen(context) async {
    await Navigator.pushNamed(
      context,
      ChatScreen.routeName,
    );
  }

  _openLoginScreen(context) async {
    await Navigator.pushReplacementNamed(
      context,
      LoginScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Users'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _openLoginScreen(context);
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _chatUsers.length,
                itemBuilder: (context, index) {
                  User user = _chatUsers[index];
                  return ListTile(
                    onTap: () {
                      G.toChatUser = user;
                      _openChatScreen(context);
                    },
                    title: Text(user.name),
                    subtitle: Text(
                      'ID ${user.email}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
