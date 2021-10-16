import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// render rating stars widget
class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  const RatingStars({Key? key, required this.rating, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: RatingBar.builder(
          initialRating: rating,
          itemCount: 5,
          ignoreGestures: true,
          direction: Axis.horizontal,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).accentColor,
          ),
          itemSize: size,
          onRatingUpdate: (rating) {},
        ));
  }
}
