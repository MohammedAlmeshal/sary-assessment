import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/heros_data.dart';

class SearchUsers extends StatefulWidget {
  SearchUsers({Key? key}) : super(key: key);

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    users = allUsers;
  }

  Widget _buildList() => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildRow(user);
      });

  Widget _buildRow(User user) => ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(user.imageURL), fit: BoxFit.fill),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.powers),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Heros'),
        ),
        body: _buildList());
  }
}
