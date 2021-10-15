import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/search_users.dart';
import './providers/users_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersModel>(
        create: (context) => UsersModel(),
        child: MaterialApp(
            theme: ThemeData(primaryColor: Colors.green),
            home: Consumer<UsersModel>(
                builder: (context, users, child) =>
                    SearchUsers(users: users.allUsers))));
  }
}
