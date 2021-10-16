import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final style = TextStyle(color: Colors.white12);

  @override
  Widget build(BuildContext context) {
    void onChanged(String query) {
      Provider.of<UsersModel>(context, listen: false).changeSearchString(query);
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[900],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: Provider.of<UsersModel>(context).searchString.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.cancel, color: style.color),
                  onTap: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          hintText: 'Search',
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
        onChanged: (query) => onChanged(query),
      ),
    );
  }
}
