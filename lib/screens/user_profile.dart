import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProfile extends StatefulWidget {
  final User user;

  UserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.user.name)),
        body: Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                ),
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(widget.user.imageURL),
                  backgroundColor: Colors.lightBlue,
                ),
                Text(widget.user.name)
              ],
            )));
    ;
  }
}
