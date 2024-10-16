import 'package:flutter/material.dart';
import 'package:lab2mobile/models/barbershop.dart';

class BarbershopRecommendation extends StatefulWidget {
  final List<Barbershop> mostRecommended;
  const BarbershopRecommendation({required this.mostRecommended, Key? key}) : super(key: key);

  @override
  _BarbershopRecommendationState createState() => _BarbershopRecommendationState();
}

class _BarbershopRecommendationState extends State<BarbershopRecommendation> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Most recommended',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF111827),
              fontWeight: FontWeight.bold,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.mostRecommended.length,
            itemBuilder: (context, index) {
              final barbershop = widget.mostRecommended[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      barbershop.imageUrl,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _BookingButton(),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.mostRecommended[_currentIndex].name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.location_on,
                text:
                '${widget.mostRecommended[_currentIndex].location} (${widget.mostRecommended[_currentIndex].distance} km)',
                iconColor: const Color(0xFF6B7280),
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.star,
                text: widget.mostRecommended[_currentIndex].rating.toString(),
                iconColor: Colors.orange,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.mostRecommended.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentIndex == index ? 35 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Color(0xFF363062) : Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.circular(_currentIndex == index ? 5 : 50),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class _BookingButton extends StatelessWidget {
  const _BookingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF363062),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: const [
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
    );
  }
}
