import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';

import '../widgets/rate_dialog.dart';

class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(user.name)),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey),
            child: Scaffold(
                body: Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 90.0,
                              backgroundImage: NetworkImage(user.imageURL),
                              backgroundColor: Colors.lightBlue,
                            ),
                            SizedBox(height: 30),
                            Text(user.name),
                            SizedBox(height: 200),
                            RateDialog(user: user)
                          ],
                        ))))));
  }
}
