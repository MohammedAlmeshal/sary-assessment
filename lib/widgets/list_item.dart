import 'package:flutter/material.dart';
import './rating_stars.dart';
import '../models/user.dart';
import '../screens/user_profile.dart';

// Shows the hero list item
class ListItem extends StatefulWidget {
  final User user;
  const ListItem({Key? key, required this.user}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  // go to hero profile page
  void _pushProfile(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UserProfile(user: user);
    }));
  }

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
      trailing: RatingStars(rating: widget.user.rating, size: 20),
      title: Text(widget.user.name),
      subtitle: Text(widget.user.powers),
      onTap: () => _pushProfile(widget.user),
    );
    ;
  }
}
