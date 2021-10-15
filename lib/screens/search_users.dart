import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/search_bar.dart';
import '../widgets/sort_dialog.dart';
import '../widgets/user_list.dart';

class SearchUsers extends StatefulWidget {
  final List<User> users;
  SearchUsers({Key? key, required this.users}) : super(key: key);

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  dynamic customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Heros');
  bool expanded = false;
  String query = '';
  late String dropdownValue = 'Name';

  void _expandSearch() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        customIcon = const Text(
          'Close',
          textAlign: TextAlign.center,
          softWrap: false,
        );
        customSearchBar = SearchBar(text: query, hintText: 'Search');
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = const Text('Heros');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
                leading: SortDialog(),
                title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: customSearchBar),
                actions: [
                  IconButton(onPressed: _expandSearch, icon: customIcon),
                ])),
        body: UserList(users: widget.users));
  }
}
