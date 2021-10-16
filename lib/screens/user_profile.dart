import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import '../widgets/rate_dialog.dart';
import '../widgets/rating_stars.dart';

// shows detailed hero profile
class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  Widget _avatar() => CircleAvatar(
        radius: 90.0,
        backgroundImage: NetworkImage(user.imageURL),
        backgroundColor: Colors.lightBlue,
      );

  Widget _name() => Text(user.name,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600));

  Widget _bio(context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Powers",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        SizedBox(width: 50),
        Expanded(
            child: Text(user.powers, style: TextStyle(color: Colors.white70)))
      ]);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
        builder: (context, users, child) => Scaffold(
            appBar: AppBar(title: Text(user.name)),
            body: Scaffold(
                body: Center(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                        child: Column(
                          children: <Widget>[
                            _avatar(),
                            SizedBox(height: 30),
                            _name(),
                            RatingStars(rating: user.rating, size: 50),
                            Divider(
                                height: 30,
                                thickness: 1,
                                color: Theme.of(context).accentColor),
                            _bio(context),
                            SizedBox(height: 150),
                            RateDialog(user: user)
                          ],
                        ))))));
  }
}
