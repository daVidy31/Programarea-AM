import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/user.dart';

class UserProfile extends StatelessWidget {
  final User user;
  final Color locationIconColor;
  final Color nameTextColor;
  final Color locationTextColor;
  final double avatarRadius;

  const UserProfile({
    required this.user,
    this.locationIconColor = const Color(0xFF363062),
    this.nameTextColor = const Color(0xFF111827),
    this.locationTextColor = const Color(0xFF6B7280),
    this.avatarRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationDisplay(
              location: user.location,
              iconColor: locationIconColor,
              textColor: locationTextColor,
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 18,
                color: nameTextColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: avatarRadius,
          child: ClipOval(
            child: user.avatarUrl.isNotEmpty
                ? Image.asset(
              user.avatarUrl,
              fit: BoxFit.cover,
              width: avatarRadius * 2,
              height: avatarRadius * 2,
            )
                : Icon(
              Icons.person,
              size: avatarRadius,
              color: Colors.grey,
            ), // Placeholder if avatarUrl is empty
          ),
        ),
      ],
    );
  }
}

class LocationDisplay extends StatelessWidget {
  final String location;
  final Color iconColor;
  final Color textColor;

  const LocationDisplay({
    required this.location,
    this.iconColor = const Color(0xFF363062),
    this.textColor = const Color(0xFF6B7280),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: iconColor,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          location,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
      ],
    );
  }
}
