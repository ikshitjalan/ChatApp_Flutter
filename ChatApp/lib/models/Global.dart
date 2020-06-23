import './Users.dart';

import '../utils/SocketUtils.dart';

class G {
  static List<User> dummyUser;

  static User loggedInUser;

  static User toChatUser;

  static SocketUtils socketUtils;

  static void initDummyUsers() {
    User userA = User(id: 1000, name: 'A', email: 'testa@gmail.com');
    User userB = User(id: 1000, name: 'B', email: 'testb@gmail.com');
    dummyUser = List();
    dummyUser.add(userA);
    dummyUser.add(userB);
  }

  static List<User> getUsersFor(User user) {
    List<User> filteredUsers = dummyUser
        .where(
          (u) => (!u.name.toLowerCase().contains(
                user.name.toLowerCase(),
              )),
        )
        .toList();
    return filteredUsers;
  }

  static initSockect() {
    if (socketUtils == null) {
      socketUtils = SocketUtils();
    }
  }
}
