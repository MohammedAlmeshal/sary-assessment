import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/heros_data.dart' as allUsersData;

enum SortBy { name, powers, rating }

class UsersModel extends ChangeNotifier {
  final List<User> _users = allUsersData.allUsers;

  String _searchString = "";
  SortBy _sortByProperty = SortBy.name;

  List<User> get allUsers {
    if (_sortByProperty == SortBy.name)
      _users.sort((a, b) => a.name.compareTo(b.name));

    return _searchString.isEmpty
        ? _users
        : _users.where((user) {
            final titleLower = user.name.toLowerCase();
            final searchLower = _searchString.toLowerCase();

            return titleLower.contains(searchLower);
          }).toList();
  }

  SortBy get sortByProperty => _sortByProperty;

  void changeSearchString(String query) {
    _searchString = query;
    notifyListeners();
  }

  void updateRating(double rating, int id) {
    final userIndex = _users.indexWhere((user) => user.id == id);
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

    notifyListeners();
  }
}
