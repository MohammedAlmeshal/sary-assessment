import 'package:flutter/material.dart';
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
        title: Text(user.name),
        subtitle: Text(user.powers),
        onTap: () => _pushProfile(user),
      );

  void _pushProfile(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UserProfile(user: user);
    }));
  }

  // Widget searchBar =
  // const ListTile(
  //   leading: Icon(Icons.search, color: Colors.white, size: 28),
  //   title: TextField(
  //     decoration: InputDecoration(
  //       hintText: 'Search',
  //       hintStyle: TextStyle(
  //         color: Colors.white,
  //         fontSize: 18,
  //       ),
  //       border: InputBorder.none,
  //     ),
  //     style: TextStyle(
  //       color: Colors.white,
  //     ),
  //   ),
  // );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
                leading: Icon(Icons.sort),
                title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: customSearchBar),
                actions: [
                  IconButton(onPressed: _expandSearch, icon: customIcon),
                ])),
        body: _buildList());
  }
}
