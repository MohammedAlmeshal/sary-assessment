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
  Widget customSearchBar = const Text('Heros');
  Widget customIcon = Icon(Icons.search);
  bool expanded = false;

  void _expandSearch() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        customIcon = TextButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.transparent,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          onPressed: _expandSearch,
          child: Text('Close', style: TextStyle(color: Colors.white)),
        );
        customSearchBar = SearchField();
      } else {
        customIcon =
            IconButton(icon: Icon(Icons.search), onPressed: _expandSearch);

        customSearchBar = const Text('Heros');
      }
    });
  }

  Widget _customTitle() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SlideTransition(
              position: Tween<Offset>(begin: Offset(1.2, 0), end: Offset(0, 0))
                  .animate(animation),
              child: child),
      child: customSearchBar);

  List<Widget> _customActions() => ([customIcon]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              leading: SortDialog(),
              title: _customTitle(),
              actions: _customActions(),
              iconTheme: IconThemeData(color: Colors.lightGreenAccent[700]),
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.green,
                    height: 0.5,
                  ),
                  preferredSize: Size.fromHeight(0.5)),
            )),
        body: UserList(users: widget.users));
  }
}
