import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import '../models/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateDialog extends StatelessWidget {
  final User user;
  const RateDialog({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Rate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                  glowColor: Colors.amber,
                  initialRating: user.rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  onRatingUpdate: (rating) =>
                      Provider.of<UsersModel>(context, listen: false)
                          .updateRating(rating, user.id)),
              Text('Swipe to rate'),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Submit'),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
