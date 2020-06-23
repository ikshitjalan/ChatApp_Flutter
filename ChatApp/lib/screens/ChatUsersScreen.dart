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

  bool _connectedToSocket;
  String _connnectMessage;
  @override
  void initState() {
    super.initState();
    _connectedToSocket = false;
    _connnectMessage = 'Connecting...';
    _chatUsers = G.getUsersFor(
      G.loggedInUser,
    );
    _connectToSocket();
  }

  _connectToSocket() {
    print(
        'Connecting Logged In User ${G.loggedInUser.name}, ${G.loggedInUser.id}');
    G.initSockect();
    G.socketUtils.initSocket(G.loggedInUser);
    G.socketUtils.connectToSocket();
    G.socketUtils.setOnConnectListner(onConnect);
    G.socketUtils.setOnConnectionErrorListener(onConnectionError);
    G.socketUtils.setOnConnectionErrorTimeoutListner(onConnectionTimeout);
    G.socketUtils.setOnDisconnectListener(onDisconnect);
    G.socketUtils.setOnErrorListener(onError);
  }

  onConnect(data) {
    setState(() {
      _connectedToSocket = true;
      _connnectMessage = 'Connected';
    });
  }

  onConnectionError(data) {
    setState(() {
      _connectedToSocket = false;
      _connnectMessage = 'Connection Error';
    });
  }

  onConnectionTimeout(data) {
    setState(() {
      _connectedToSocket = false;
      _connnectMessage = 'Connection Timeout';
    });
  }

  onError(data) {
    setState(() {
      _connectedToSocket = false;
      _connnectMessage = 'Connection Error';
    });
  }

  onDisconnect(data) {
    setState(() {
      _connectedToSocket = false;
      _connnectMessage = 'Connection Disconnected';
    });
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
            Text(
              _connectedToSocket ? 'Connected' : _connnectMessage,
            ),
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
