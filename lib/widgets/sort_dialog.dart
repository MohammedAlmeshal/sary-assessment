import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';

class SortDialog extends StatefulWidget {
  SortDialog({Key? key}) : super(key: key);

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  void _showSortDialog() async {
    switch (await showDialog<SortBy>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Sort By'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SortBy.name);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Name"),
                      if (Provider.of<UsersModel>(context, listen: false)
                              .sortByProperty ==
                          SortBy.name)
                        Icon(Icons.done)
                    ]),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SortBy.powers);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Powers"),
                      if (Provider.of<UsersModel>(context, listen: false)
                              .sortByProperty ==
                          SortBy.powers)
                        Icon(Icons.done)
                    ]),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SortBy.rating);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Rating"),
                      if (Provider.of<UsersModel>(context, listen: false)
                              .sortByProperty ==
                          SortBy.rating)
                        Icon(Icons.done)
                    ]),
              ),
            ],
          );
        })) {
      case SortBy.name:
        Provider.of<UsersModel>(context, listen: false).sortBy(SortBy.name);
        break;
      case SortBy.powers:
        Provider.of<UsersModel>(context, listen: false).sortBy(SortBy.powers);
        break;
      case SortBy.rating:
        Provider.of<UsersModel>(context, listen: false).sortBy(SortBy.rating);
        break;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
        builder: (context, users, child) =>
            IconButton(icon: Icon(Icons.sort), onPressed: _showSortDialog));
  }
}
