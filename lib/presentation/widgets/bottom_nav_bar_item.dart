import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  final int index;
  final String title;
  final String imageSelected;
  final String imageUnselected;
  final bool isSelected;
  const BottomNavBarItem({
    super.key,
    required this.index,
    required this.title,
    required this.imageSelected,
    required this.imageUnselected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isSelected ? imageSelected : imageUnselected,
          width: 25,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
