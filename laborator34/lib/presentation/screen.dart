import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lab2mobile/presentation/widgets/card.dart';
import 'package:lab2mobile/presentation/widgets/card-extend.dart';
import 'package:lab2mobile/presentation/widgets/all.dart';
import 'package:lab2mobile/presentation/widgets/user_profile.dart';
import 'package:lab2mobile/presentation/widgets/search.dart' as custom;
import 'package:lab2mobile/presentation/widgets/booking.dart';
import 'package:lab2mobile/domain/barbershop.dart';
import 'package:lab2mobile/data/static.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('lib/data/v2.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: FutureBuilder<Map<String, dynamic>>(
          future: loadJsonData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            final jsonData = snapshot.data!;
            final nearestBarbershops = (jsonData['nearest_barbershop'] as List)
                .map((item) => Barbershop.fromJson(item))
                .toList();
            final mostRecommended = (jsonData['most_recommended'] as List)
                .map((item) => Barbershop.fromJson(item))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                UserProfile(
                    user: currentUser), // Folosim currentUser din static_data
                SizedBox(height: 30),
                BookingCard(),
                SizedBox(height: 30),
                custom.SearchBar(controller: TextEditingController()),

                // Nearest Barbershop Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Nearest Barbershop',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ),
                ...nearestBarbershops
                    .map((barbershop) => BarbershopCard(barbershop: barbershop))
                    .toList(),

                Center(child: SeeAllButton()),

                // Most Recommended Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Most Recommended',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ),
                BarbershopRecommendation(),
              ],
            );
          },
        ),
      ),
    );
  }
}