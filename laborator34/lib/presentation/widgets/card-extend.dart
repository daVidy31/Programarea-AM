import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lab2mobile/domain/barbershop.dart';
import 'package:lab2mobile/presentation/widgets/card.dart';

class BarbershopRecommendation extends StatefulWidget {
  @override
  _BarbershopRecommendationState createState() =>
      _BarbershopRecommendationState();
}

class _BarbershopRecommendationState extends State<BarbershopRecommendation> {
  int _currentIndex = 0;
  List<Barbershop> listBarbershops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadListData();
  }

  Future<void> loadListData() async {
    try {
      final String jsonString = await rootBundle.loadString('lib/data/v2.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      print('Loaded JSON data: ${jsonData['list']}');

      setState(() {
        listBarbershops = (jsonData['list'] as List)
            .map((item) => Barbershop.fromJson(item))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading JSON data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (listBarbershops.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BarbershopImage(
          imageUrl: listBarbershops[_currentIndex].imageUrl,
          onPressed: () {
            // Add navigation or other action for the Booking button
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listBarbershops[_currentIndex].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              SizedBox(height: 8),
              LocationRow(
                location: listBarbershops[_currentIndex].location,
                distance: listBarbershops[_currentIndex].distance,
              ),
              SizedBox(height: 8),
              RatingRow(rating: listBarbershops[_currentIndex].rating),
            ],
          ),
        ),
        DotsIndicator(
          itemCount: listBarbershops.length,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        ...listBarbershops.map((barbershop) => BarbershopCard(barbershop: barbershop)),
      ],
    );
  }
}

class BarbershopImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;

  const BarbershopImage({
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 230,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: double.infinity,
                height: 230,
                color: Colors.grey[200],
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
                width: double.infinity,
                height: 230,
                color: Colors.grey[200],
                child: Icon(Icons.error),
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF363062),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const DotsIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(itemCount, (index) {
        return GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: currentIndex == index ? 35 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentIndex == index ? Color(0xFF363062) : Color(0xFFC4C4C4),
              borderRadius: currentIndex == index
                  ? BorderRadius.circular(5)
                  : BorderRadius.circular(50),
            ),
          ),
        );
      }),
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
        Icon(Icons.location_on, size: 16, color: Color(0xFF6B7280)),
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
        Icon(Icons.star, size: 16, color: Colors.orange),
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
