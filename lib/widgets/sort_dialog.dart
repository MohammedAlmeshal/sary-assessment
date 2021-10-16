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
                child: const Text('Name'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SortBy.powers);
                },
                child: const Text('Power'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SortBy.rating);
                },
                child: const Text('Rating'),
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
    return IconButton(icon: Icon(Icons.sort), onPressed: _showSortDialog);
  }
}
