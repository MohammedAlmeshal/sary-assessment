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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(user.imageURL),
                  backgroundColor: Colors.lightBlue,
                ),
                Text(user.name),
                RateDialog(user: user)
              ],
            )));
  }
}
