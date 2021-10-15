import 'package:flutter/material.dart';
import '../data/heros_data.dart' as allUsersData;

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
}

enum SortBy { name, powers, rating }

class UsersModel extends ChangeNotifier {
  final List<User> _users = allUsersData.allUsers;
  String _searchString = "";
  late SortBy _sortByProperty = SortBy.name;

  List<User> get allUsers => _searchString.isEmpty
      ? _users
      : _users.where((user) {
          final titleLower = user.name.toLowerCase();
          final searchLower = _searchString.toLowerCase();

          return titleLower.contains(searchLower);
        }).toList();

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }

  void updateRating(double rating, int id) {
    final userIndex = allUsers.indexWhere((user) => user.id == id);
    _users[userIndex].updateRating(rating);

    if (_sortByProperty == SortBy.rating) sortBy(SortBy.rating);
    notifyListeners();
  }

  void sortBy(SortBy sortByProperty) {
    switch (sortByProperty) {
      case SortBy.name:
        _sortByProperty = SortBy.name;
        _users.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortBy.powers:
        _sortByProperty = SortBy.powers;
        _users.sort((a, b) => a.powers.compareTo(b.powers));
        break;
      case SortBy.rating:
        _sortByProperty = SortBy.rating;
        _users.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    print(_sortByProperty);
    notifyListeners();
  }
}
