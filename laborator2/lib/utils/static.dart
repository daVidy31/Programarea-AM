import '../models/user.dart';
import '../models/barbershop.dart';

final User currentUser = User(
  name: 'David Plesu',
  location: 'Chisinau',
  avatarUrl: 'assets/images/avatar.png',
);

final List<Barbershop> nearestBarbershops = [
  Barbershop(
    name: 'Alana Barbershop - Haircut massage & Spa',
    location: 'Banguntapan',
    distance: 5,
    rating: 4.511,
    imageUrl: 'assets/images/img2.png',
  ),
  Barbershop(
    name: 'Hercha Barbershop - Haircut & Styling',
    location: 'Jalan Kaliurang',
    distance: 8,
    rating: 5.0,
    imageUrl: 'assets/images/img3.png',
  ),
  Barbershop(
    name: 'Barberking - Haircut styling  & massage',
    location: 'Jogja Expo Centre',
    distance: 12,
    rating: 4.5,
    imageUrl: 'assets/images/img6.png',
  ),
];

final List<Barbershop> mostRecommended = [
  Barbershop(
    name: 'Master piece Barbershop - Haircut styling',
    location: 'Joga Expo Centre',
    distance: 2,
    rating: 5.0,
    imageUrl: 'assets/images/img4.png',
  ),
  Barbershop(
    name: 'Varcity Barbershop Jogja ex The Varcher',
    location: 'Condongcatur',
    distance: 10,
    rating: 4.5,
    imageUrl: 'assets/images/img5.png',
  ),
  Barbershop(
    name: 'Twinsky Monkey Barber & Men Stuff',
    location: 'Jl Taman Siswa',
    distance: 8,
    rating: 5.0,
    imageUrl: 'assets/images/img7.png',
  ),
  Barbershop(
    name: 'Barberman - Haircut styling & massage',
    location: 'J-Walk Centre',
    distance: 17,
    rating: 4.5,
    imageUrl: 'assets/images/img8.png',
  ),
];
