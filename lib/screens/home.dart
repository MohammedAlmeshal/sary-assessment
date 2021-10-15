import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/search_field.dart';
import '../widgets/sort_dialog.dart';
import '../widgets/user_list.dart';

class Home extends StatefulWidget {
  final List<User> users;
  Home({Key? key, required this.users}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Heros');
  bool expanded = false;

  void _expandSearch() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        customIcon = const Text(
          'Close',
          textAlign: TextAlign.center,
          softWrap: false,
        );
        customSearchBar = SearchField();
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = const Text('Heros');
      }
    });
  }

  Widget _customTitle() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 200), child: customSearchBar);

  List<Widget> _customActions() =>
      ([IconButton(onPressed: _expandSearch, icon: customIcon)]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
                leading: SortDialog(),
                title: _customTitle(),
                actions: _customActions(),
                iconTheme: IconThemeData(color: Colors.lightGreenAccent[700]))),
        body: UserList(users: widget.users));
  }
}
