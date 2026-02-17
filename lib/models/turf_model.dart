class TurfModel {
  final String id;
  final String name;
  final String location;
  final List<String> sports;
  final double pricePerHour;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> amenities;
  final String openTime;
  final String closeTime;
  final List<String> images;
  final bool isPopular;
  final String discount;

  TurfModel({
    required this.id,
    required this.name,
    required this.location,
    required this.sports,
    required this.pricePerHour,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.amenities,
    required this.openTime,
    required this.closeTime,
    required this.images,
    this.isPopular = false,
    this.discount = '',
  });

  static List<TurfModel> getDummyTurfs() {
    return [
      TurfModel(
        id: '1',
        name: 'Green Arena Sports Complex',
        location: 'Near Shastri Circle, Bhilwara',
        sports: ['Cricket', 'Football'],
        pricePerHour: 800,
        rating: 4.8,
        reviewCount: 156,
        description: 'International-standard turf with premium facilities. Perfect for cricket and football enthusiasts looking for a professional gaming experience.',
        amenities: ['Floodlights', 'Changing Room', 'Parking', 'Drinking Water', 'First Aid'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['turf1.jpg', 'turf1_2.jpg', 'turf1_3.jpg'],
        isPopular: true,
        discount: '10% OFF',
      ),
      TurfModel(
        id: '2',
        name: 'Victory Turf Ground',
        location: 'Rajendra Marg, Bhilwara',
        sports: ['Football', 'Cricket'],
        pricePerHour: 700,
        rating: 4.6,
        reviewCount: 98,
        description: 'Modern synthetic turf with spectacular seating. Book early morning or night - play when it suits you.',
        amenities: ['Floodlights', 'Parking', 'Washroom'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['turf2.jpg', 'turf2_2.jpg'],
        isPopular: true,
      ),
      TurfModel(
        id: '3',
        name: 'Shuttle Zone Badminton',
        location: 'Pur Road, Bhilwara',
        sports: ['Badminton'],
        pricePerHour: 400,
        rating: 4.9,
        reviewCount: 237,
        description: 'Indoor AC badminton courts with wooden flooring. Professional-grade courts for serious players.',
        amenities: ['Air Conditioning', 'Wooden Flooring', 'Racket Rental', 'Parking'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['badminton1.jpg'],
        isPopular: true,
      ),
      TurfModel(
        id: '4',
        name: 'Champion\'s Cricket Academy',
        location: 'Sanjay Colony, Bhilwara',
        sports: ['Cricket'],
        pricePerHour: 600,
        rating: 4.7,
        reviewCount: 203,
        description: 'Professional cricket training facility. FIFA-approved 5-a-side football turf with premium facilities.',
        amenities: ['Practice Nets', 'Bowling Machine', 'Coaching', 'Parking'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['cricket1.jpg'],
        discount: '15% OFF',
      ),
      TurfModel(
        id: '5',
        name: 'Power Play Arena',
        location: 'Azad Nagar, Bhilwara',
        sports: ['Cricket', 'Football', 'Box Cricket'],
        pricePerHour: 900,
        rating: 4.5,
        reviewCount: 87,
        description: 'Multi-sport facility for all occasions. Your booking is confirmed instantly - no waiting, no hassle.',
        amenities: ['Floodlights', 'Changing Room', 'Parking', 'Canteen'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['multi1.jpg'],
      ),
      TurfModel(
        id: '6',
        name: 'Goal Striker Football Turf',
        location: 'Pur Colony, Bhilwara',
        sports: ['Football'],
        pricePerHour: 1000,
        rating: 4.8,
        reviewCount: 178,
        description: 'FIFA-approved 5-a-side football turf with premium facilities. Perfect for football enthusiasts.',
        amenities: ['FIFA Turf', 'Floodlights', 'Goal Posts', 'Parking'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['football1.jpg'],
        isPopular: true,
        discount: '5% OFF',
      ),
    ];
  }

  static List<String> getTimeSlots() {
    return [
      '06:00', '07:00', '08:00', '09:00', '10:00', '11:00',
      '12:00', '13:00', '14:00', '15:00', '16:00', '17:00',
      '18:00', '19:00', '20:00', '21:00', '22:00', '23:00',
    ];
  }
}