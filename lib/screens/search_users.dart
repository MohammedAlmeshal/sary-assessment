import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';
import '../data/heros_data.dart';
import './user_profile.dart';
import '../widgets/search_bar.dart';

class SearchUsers extends StatefulWidget {
  SearchUsers({Key? key}) : super(key: key);

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  late List<User> users;
  dynamic customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Heros');
  bool expanded = false;
  String query = '';
  late String dropdownValue = 'Name';

  @override
  void initState() {
    super.initState();
    users = allUsers;
  }

  Widget _buildList() => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildRow(user);
      });

  Widget _buildRow(User user) => ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(user.imageURL), fit: BoxFit.fill),
          ),
        ),
        trailing: RatingBar.builder(
          initialRating: user.rating,
          itemCount: 5,
          ignoreGestures: true,
          direction: Axis.horizontal,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 20,
          onRatingUpdate: (rating) {},
        ),
        // Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: _starRatings(user.rating)),
        title: Text(user.name),
        subtitle: Text(user.powers),
        onTap: () => _pushProfile(user),
      );

  // List<Icon> _starRatings(double rating) {
  //   List<Icon> stars = [];
  //   for (int i = 0; i < 5; i++) {
  //     stars.add(Icon(Icons.star,
  //         size: 20, color: i >= rating ? Colors.grey : Colors.amber));
  //   }
  //   return stars;
  // }

  void updateRating(double rating, int id) {
    // check it correct
    final index = allUsers.indexWhere((user) => user.id == id);
    print(rating);
    allUsers[index].rating = rating;

    setState(() {
      this.users = allUsers;
    });
  }

  void _pushProfile(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UserProfile(user: user, updateRating: updateRating);
    }));
  }

  void _expandSearch() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        customIcon = const Text(
          'Close',
          textAlign: TextAlign.center,
          softWrap: false,
        );
        customSearchBar =
            SearchBar(text: query, hintText: 'Search', onChanged: searchUsers);
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = const Text('Heros');
      }
    });
  }

  void searchUsers(String query) {
    final users = allUsers.where((user) {
      final titleLower = user.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.users = users;
    });
  }

  void _showFilter() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Filter'),
            content: Row(children: [
              Text('Sort By'),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Name', 'Power']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ]),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Apply');
                  setState(() {
                    if (dropdownValue == 'Power') {
                      this.users.sort((a, b) => b.rating.compareTo(a.rating));
                    } else {
                      this.users.sort((a, b) => a.name.compareTo(b.name));
                    }
                  });
                },
                child: const Text('Apply'),
              ),
            ]);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
                leading:
                    IconButton(icon: Icon(Icons.sort), onPressed: _showFilter),
                title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: customSearchBar),
                actions: [
                  IconButton(onPressed: _expandSearch, icon: customIcon),
                ])),
        body: _buildList());
  }
}
