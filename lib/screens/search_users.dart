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

  void _showSortDialog() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Sort By'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Name');
                },
                child: const Text('Name'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Power');
                },
                child: const Text('Power'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Rating');
                },
                child: const Text('Rating'),
              ),
            ],
          );
        })) {
      case 'Name':
        setState(() {
          this.users.sort((a, b) => a.name.compareTo(b.name));
        });
        break;
      case 'Power':
        setState(() {
          this.users.sort((a, b) => a.powers.compareTo(b.powers));
        });
        break;
      case 'Rating':
        setState(() {
          this.users.sort((a, b) => b.rating.compareTo(a.rating));
        });
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.sort), onPressed: _showSortDialog),
                title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: customSearchBar),
                actions: [
                  IconButton(onPressed: _expandSearch, icon: customIcon),
                ])),
        body: _buildList());
  }
}
