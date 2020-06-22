import 'package:flutter/material.dart';

import './ChatUsersScreen.dart';
import '../models/Users.dart';
import '../models/Global.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController;
  void initState() {
    super.initState();
    G.initDummyUsers();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Chat'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(20.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              child: Text('Login'),
              onPressed: () {
                _loginBtnTap();
              },
            ),
          ],
        ),
      ),
    );
  }

  _loginBtnTap() {
    if (_usernameController.text.isEmpty) {
      return;
    }
    User me = G.dummyUser[0];

    if (_usernameController.text != 'a') {
      me = G.dummyUser[1];
    }
    G.loggedInUser = me;
    _openChatUsersScreen(context);
  }

  _openChatUsersScreen(context) async {
    await Navigator.pushReplacementNamed(
      context,
      ChatUsersScreen.routeName,
    );
  }
}
