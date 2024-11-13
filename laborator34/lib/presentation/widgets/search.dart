import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;
  final Color backgroundColor;
  final Color iconColor;
  final Color filterIconColor;
  final Color hintColor;

  const SearchBar({
    required this.controller,
    this.onChanged,
    this.onFilterPressed,
    this.backgroundColor = const Color(0xFFEBF0F5),
    this.iconColor = const Color.fromARGB(255, 162, 165, 172),
    this.filterIconColor = const Color(0xFFFFFFFF),
    this.hintColor = const Color(0xFF6B7280),
  });

  @override
  Widget build(BuildContext context) {
    const paddingValue = 20.0;
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: iconColor,
                ),
                SizedBox(width: paddingValue),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: "Search barber's, haircut ser...",
                      hintStyle: TextStyle(
                        color: hintColor,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: paddingValue),
        GestureDetector(
          onTap: onFilterPressed,
          child: Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Color(0xFF363062),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.tune, color: filterIconColor),
          ),
        ),
      ],
    );
  }
}
