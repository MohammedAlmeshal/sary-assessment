import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import './list_item.dart';

// render list of hero list tiles
class UserList extends StatelessWidget {
  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
        builder: (context, users, child) => ListView.separated(
              itemCount: users.allUsers.length,
              itemBuilder: (context, index) {
                final user = users.allUsers[index];
                return ListItem(user: user);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ));
  }
}
