import 'package:flutter/material.dart';

import './screens/ChatScreen.dart';
import './screens/LoginScreen.dart';
import './screens/ChatUsersScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        ChatUsersScreen.routeName: (context) => ChatUsersScreen(),
      },
    );
  }
}
