class Barbershop {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final String distance;

  Barbershop({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.distance,
  });

  factory Barbershop.fromJson(Map<String, dynamic> json) {
    // Extract location and distance from the combined location_with_distance field
    final locationWithDistance = json['location_with_distance'] as String;
    final locationParts = locationWithDistance.split('(');
    final location = locationParts[0].trim();
    final distance = locationParts.length > 1
        ? locationParts[1].replaceAll(')', '').trim()
        : '';

    return Barbershop(
      name: json['name'],
      location: location,
      imageUrl: json['image'],
      rating: (json['review_rate'] as num).toDouble(),
      distance: distance,
    );
  }
}
