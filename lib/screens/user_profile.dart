import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/user.dart';

class UserProfile extends StatefulWidget {
  final User user;
  final Function updateRating;

  UserProfile({
    Key? key,
    required this.user,
    required this.updateRating,
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
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(widget.user.imageURL),
                  backgroundColor: Colors.lightBlue,
                ),
                Text(widget.user.name),
                RatingBar.builder(
                  glowColor: Colors.amber,
                  initialRating: widget.user.rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) =>
                      widget.updateRating(rating, widget.user.id),
                )
              ],
            )));
  }
}
