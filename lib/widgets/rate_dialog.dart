import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import '../models/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateDialog extends StatelessWidget {
  final User user;
  const RateDialog({Key? key, required this.user}) : super(key: key);

  Widget _ratingBar(context) => RatingBar.builder(
      glowColor: Theme.of(context).accentColor,
      initialRating: user.rating,
      minRating: 0,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).accentColor,
          ),
      onRatingUpdate: (rating) =>
          Provider.of<UsersModel>(context, listen: false)
              .updateRating(rating, user.id));
  @override
  Widget build(BuildContext context) {
    Future<String?> _showDialog() => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Rate Hero'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ratingBar(context),
                SizedBox(height: 10),
                Text('Swipe to rate',
                    style: TextStyle(fontSize: 12, color: Colors.white70)),
                SizedBox(height: 30),
                SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'Submit'),
                      child: const Text('Submit'),
                    ))
              ],
            ),
          ),
        );
    return SizedBox(
        width: 200,
        height: 45,
        child: ElevatedButton(
            onPressed: () => _showDialog(),
            child: const Text('Rate Hero', style: TextStyle(fontSize: 16)),
            style: ButtonStyle()));
  }
}
