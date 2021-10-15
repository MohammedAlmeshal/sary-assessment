import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users_model.dart';

class SearchBar extends StatelessWidget {
  final String text;
  final String hintText;

  SearchBar({
    Key? key,
    required this.text,
    required this.hintText,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.black26);

    void onChanged(String query) {
      Provider.of<UsersModel>(context, listen: false).changeSearchString(query);
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white38,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.red,
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: GestureDetector(
            child: Icon(Icons.cancel, color: style.color),
            onTap: () {
              controller.clear();
              onChanged('');
            },
          ),
          hintText: hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (query) => onChanged(query),
      ),
    );
  }
}
