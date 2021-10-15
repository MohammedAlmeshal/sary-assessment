class User {
  final int id;
  final String name;
  final String powers;
  final String imageURL;
  double rating;

  User({
    required this.id,
    required this.name,
    required this.powers,
    required this.imageURL,
    required this.rating,
  });

  void updateRating(double rating) {
    this.rating = rating;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        powers = json['powers'],
        imageURL = json['imageURL'],
        rating = json['rating'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'powers': powers,
        'imageURL': imageURL,
        'rating': rating,
      };
}
