import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';
import '../screens/user_profile.dart';

class ListItem extends StatefulWidget {
  final User user;
  const ListItem({Key? key, required this.user}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  void _pushProfile(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UserProfile(user: user);
    }));
  }

  Widget _ratingBar() => RatingBar.builder(
        initialRating: widget.user.rating,
        itemCount: 5,
        ignoreGestures: true,
        direction: Axis.horizontal,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Theme.of(context).accentColor,
        ),
        itemSize: 20,
        onRatingUpdate: (rating) {},
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(widget.user.imageURL), fit: BoxFit.fill),
        ),
      ),
      trailing: _ratingBar(),
      title: Text(widget.user.name),
      subtitle: Text(widget.user.powers),
      onTap: () => _pushProfile(widget.user),
    );
    ;
  }
}
