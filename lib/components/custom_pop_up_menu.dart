import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatelessWidget {
  final void Function(String)? onSelected;
  final Color color;
  final List<PopupMenuItem<String>> items;
  const CustomPopUpMenu({
    super.key,
    required this.onSelected,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: color,
      onSelected: onSelected,
      itemBuilder: (context) => items,
      icon: const Icon(Icons.more_vert),
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      padding: const EdgeInsets.all(0),
    );
  }
}
