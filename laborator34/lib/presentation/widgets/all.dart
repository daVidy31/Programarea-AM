import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final EdgeInsets padding;

  const SeeAllButton({
    this.text = 'See All',
    this.onTap,
    this.color = const Color(0xFF2E2769),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.open_in_new,
              color: color,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
