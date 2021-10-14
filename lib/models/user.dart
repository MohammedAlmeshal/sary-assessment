class User {
  final int id;
  final String name;
  final String powers;
  final String imageURL;
  final int? rating;

  const User({
    required this.id,
    required this.name,
    required this.powers,
    required this.imageURL,
    this.rating,
  });
}
