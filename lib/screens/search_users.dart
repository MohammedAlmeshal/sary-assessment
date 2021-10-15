import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/user.dart';
import '../providers/users_model.dart';
import './user_profile.dart';
import '../widgets/search_bar.dart';
import '../widgets/sort_dialog.dart';

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

  Widget _buildList() => ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        final user = widget.users[index];
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

  void _pushProfile(User user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UserProfile(user: user);
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
        customSearchBar = SearchBar(text: query, hintText: 'Search');
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = const Text('Heros');
      }
    });
  }

  void _showSortDialog() async {
    switch (await showDialog<SortBy>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
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
                leading: SortDialog(),
                title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: customSearchBar),
                actions: [
                  IconButton(onPressed: _expandSearch, icon: customIcon),
                ])),
        body: _buildList());
  }
}
