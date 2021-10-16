import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import './providers/users_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ThemeData _dark = ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      dialogBackgroundColor: Color(0xFF121212),
      dividerColor: Colors.grey,
      accentColor: Colors.green,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.black,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        // ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(18.0),
        //     )))
        //
        //ElevatedButton.styleFrom(primary: Colors.green
      ));

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersModel>(
        create: (context) => UsersModel(),
        child: MaterialApp(
            theme: _dark,
            home: Consumer<UsersModel>(
                builder: (context, users, child) =>
                    Home(users: users.allUsers))));
  }
}
