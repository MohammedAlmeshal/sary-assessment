import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/users_model.dart';
import 'screens/home.dart';
import './theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersModel>(
        create: (context) => UsersModel(),
        child: MaterialApp(
            theme: customTheme,
            home: Consumer<UsersModel>(
                builder: (context, users, child) =>
                    Home(users: users.allUsers))));
  }
}
