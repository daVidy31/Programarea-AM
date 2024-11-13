import 'package:flutter/material.dart';
import 'package:lab2mobile/widgets/card.dart';
import 'package:lab2mobile/widgets/card-extend.dart';
import 'package:lab2mobile/widgets/all.dart';
import 'package:lab2mobile/widgets/user_profile.dart';
import 'package:lab2mobile/widgets/search.dart' as custom;
//importBookingCard
import '../widgets/booking.dart';
import '../models/user.dart';
import '../utils/static.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(Object context) {
    // TODO: implement build
    //return text('Home Screen');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //set color white for background

        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            UserProfile(user: currentUser),
            SizedBox(height: 30),
            BookingCard(),
            SizedBox(height: 30),
            custom.SearchBar(controller: TextEditingController()),

            //TExt Nearest Babershop
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
            Column(
              children: nearestBarbershops.map((barbershop) {
                return BarbershopCard(barbershop: barbershop);
              }).toList(),
            ),

            Center(
              child: SeeAllButton(),
            ),

            BarbershopRecommendation(mostRecommended: mostRecommended),

            Column(
              children: mostRecommended.map((barbershop) {
                return BarbershopCard(barbershop: barbershop);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}