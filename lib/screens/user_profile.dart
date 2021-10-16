import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import '../widgets/rate_dialog.dart';

class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  Widget _ratingBar() => Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RatingBar.builder(
        initialRating: user.rating,
        itemCount: 5,
        ignoreGestures: true,
        direction: Axis.horizontal,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Theme.of(context).accentColor,
        ),
        itemSize: 50,
        onRatingUpdate: (rating) {},
      ));

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
        builder: (context, users, child) => Scaffold(
            appBar: AppBar(title: Text(user.name)),
            body: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey),
                child: Scaffold(
                    body: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 30),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 90.0,
                                  backgroundImage: NetworkImage(user.imageURL),
                                  backgroundColor: Colors.lightBlue,
                                ),
                                SizedBox(height: 30),
                                Text(user.name,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600)),
                                _ratingBar(),
                                Divider(
                                    height: 30,
                                    thickness: 1,
                                    color: Theme.of(context).accentColor),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Powers",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 50),
                                      Expanded(
                                          child: Text(user.powers,
                                              style: TextStyle(
                                                  color: Colors.white70)))
                                    ]),
                                SizedBox(height: 150),
                                RateDialog(user: user)
                              ],
                            )))))));
  }
}
