import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;
  final String hintText;

  const SearchBar({
    required this.controller,
    this.onFilterTap,
    this.hintText = "Search barber's, haircut ser...",
    Key? key,
  }) : super(key: key);

  static const Color searchBarColor = Color(0xFFEBF0F5);
  static const Color iconColor = Color.fromARGB(255, 162, 165, 172);
  static const Color filterIconBackground = Color(0xFF363062);
  static const EdgeInsets searchPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets filterPadding = EdgeInsets.all(13);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: searchPadding,
            decoration: BoxDecoration(
              color: searchBarColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: iconColor),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFF6B7280),
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
        const SizedBox(width: 20),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            padding: filterPadding,
            decoration: BoxDecoration(
              color: filterIconBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
