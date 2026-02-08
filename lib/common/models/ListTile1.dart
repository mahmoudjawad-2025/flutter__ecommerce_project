import 'package:flutter/material.dart';

class ListTile1 extends StatelessWidget {
  final String text;
  final void Function() function;
  final IconData icon;

  const ListTile1({
    super.key,
    required this.text,
    required this.function,
    this.icon = Icons.home,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
        ),
      ),
      onTap: function,
    );
  }
}
