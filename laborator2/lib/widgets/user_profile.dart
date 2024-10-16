import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProfile extends StatelessWidget {
  final User user;

  const UserProfile({required this.user, Key? key}) : super(key: key);

  static const Color locationIconColor = Color(0xFF363062);
  static const Color locationTextColor = Color(0xFF6B7280);
  static const Color nameTextColor = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LocationInfo(location: user.location),
            const SizedBox(height: 4),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 18,
                color: nameTextColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.asset(
              user.avatarUrl,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, size: 60, color: locationIconColor);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationInfo extends StatelessWidget {
  final String location;

  const _LocationInfo({required this.location, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: UserProfile.locationIconColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          location,
          style: const TextStyle(
            fontSize: 14,
            color: UserProfile.locationTextColor,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
      ],
    );
  }
}
