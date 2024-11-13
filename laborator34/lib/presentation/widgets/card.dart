import 'package:flutter/material.dart';
import 'package:lab2mobile/domain/barbershop.dart';

class BarbershopCard extends StatelessWidget {
  final Barbershop barbershop;

  const BarbershopCard({required this.barbershop});

  @override
  Widget build(BuildContext context) {
    const placeholderColor = Colors.grey;

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                barbershop.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 100,
                    height: 100,
                    color: placeholderColor[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: placeholderColor[200],
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barbershop.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 5),
                  LocationRow(
                    location: barbershop.location,
                    distance: barbershop.distance,
                  ),
                  SizedBox(height: 5),
                  RatingRow(rating: barbershop.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationRow extends StatelessWidget {
  final String location;
  final String distance;

  const LocationRow({required this.location, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Color(0xFF6B7280),
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          '$location ($distance km)',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class RatingRow extends StatelessWidget {
  final double rating;

  const RatingRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.orange,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}
