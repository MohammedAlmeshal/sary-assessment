import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';
import '../models/user.dart';
import '../widgets/search_field.dart';
import '../widgets/sort_dialog.dart';
import '../widgets/user_list.dart';

// home screen with hero list & search bar & sort dialog
class Home extends StatefulWidget {
  final List<User> users;
  Home({Key? key, required this.users}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget customSearchBar = const Text('Heros');
  late Widget customIcon;
  bool expanded = false;

  _HomeState() {
    customIcon = IconButton(icon: Icon(Icons.search), onPressed: _toggleSearch);
  }
  void _toggleSearch() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        customIcon = TextButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.transparent,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          onPressed: _toggleSearch,
          child: Text('Close', style: TextStyle(color: Colors.white)),
        );
        customSearchBar = SearchField();
      } else {
        Provider.of<UsersModel>(context, listen: false).changeSearchString('');
        customIcon =
            IconButton(icon: Icon(Icons.search), onPressed: _toggleSearch);
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
                    color: Theme.of(context).accentColor,
                    height: 0.5,
                  ),
                  preferredSize: Size.fromHeight(0.5)),
            )),
        body: UserList());
  }
}
