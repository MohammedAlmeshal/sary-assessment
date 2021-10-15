import 'package:flutter/material.dart';
import '../models/user.dart';
import './list_item.dart';

class UserList extends StatelessWidget {
  final List<User> users;

  const UserList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListItem(user: user);
        });
  }
}
