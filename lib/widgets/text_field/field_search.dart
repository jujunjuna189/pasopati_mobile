import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';

class FieldSearch extends StatelessWidget {
  const FieldSearch({Key? key, this.onChange}) : super(key: key);

  final Function? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: bgWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(fontSize: 16),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.search, size: 20),
          ),
          border: InputBorder.none,
        ),
        onChanged: ((value) {
          onChange!(value);
        }),
      ),
    );
  }
}
