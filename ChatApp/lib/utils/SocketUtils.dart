import 'dart:io';

import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../models/Users.dart';
import '../models/ChatMessageModel.dart';

class SocketUtils {
  static String _serverIP =
      Platform.isIOS ? 'http://localhost' : 'http://10.0.2.2';
  static const int SERVER_PORT = 5000;
  static String _connectUrl = '$_serverIP:$SERVER_PORT';

  //Events
  static const String _ON_MESSAGE_RECEIVED = 'receive_message';
  static const String _IS_USER_ONLINE_SENT = 'check_online';

  //Status
  static const int STATUS_MESSAGE_NOT_SENT = 10001;
  static const int STATUS_MESSAGE_SENT = 10002;

  //Type of Chat
  static const String SINGLE_CHAT = 'single_chat';

  User _fromUser;

  SocketIO _socket;
  SocketIOManager _manager;

  initSocket(User fromUser) async {
    this._fromUser = fromUser;
    print('Connecting...${fromUser.name}');
    await _init();
  }

  connectToSocket() {
    if (_socket == null) {
      print('Socket is null');
      return;
    }
    _socket.connect();
  }

  _init() async {
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(
      _socketOptions(),
    );
  }

  _socketOptions() {
    final Map<String, String> userMap = {
      'from': _fromUser.id.toString(),
    };
    return SocketOptions(
      _connectUrl,
      enableLogging: true,
      transports: [Transports.WEB_SOCKET],
      query: userMap,
    );
  }

  setOnConnectListner(Function onConnect) {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setOnConnectionErrorTimeoutListner(Function onConnectionTimeout) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeout(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError) {
    _socket.onConnectError((data) {
      onConnectionError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      onError(data);
    });
  }

  setOnDisconnectListener(Function onDisconnect) {
    _socket.onDisconnect((data) {
      onDisconnect(data);
    });
  }

  closeConnection() {
    if (_socket != null) {
      print('Closing Connection');
      _manager.clearInstance(_socket);
    }
  }
}
