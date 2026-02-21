// Basic Flutter widget test for Bhilwara Turf App

import 'package:flutter_test/flutter_test.dart';
import 'package:bhilwara_turf/models/turf_model.dart';

void main() {
  group('TurfModel Tests', () {
    test('TurfModel creates correctly', () {
      final turf = TurfModel(
        id: '1',
        name: 'Test Turf',
        location: 'Test Location',
        sports: ['Cricket'],
        pricePerHour: 500.0,
        rating: 4.5,
        reviewCount: 10,
        description: 'Test description',
        amenities: ['Parking', 'Lights'],
        openTime: '06:00',
        closeTime: '23:00',
        images: ['test.jpg'],
      );

      expect(turf.id, '1');
      expect(turf.name, 'Test Turf');
      expect(turf.pricePerHour, 500.0);
      expect(turf.rating, 4.5);
      expect(turf.amenities.length, 2);
      expect(turf.sports.contains('Cricket'), true);
    });

    test('getDummyTurfs returns list of turfs', () {
      final turfs = TurfModel.getDummyTurfs();
      
      expect(turfs.isNotEmpty, true);
      expect(turfs.length, 6);
      expect(turfs.first.name, 'Green Arena Sports Complex');
    });

    test('getTimeSlots returns valid time slots', () {
      final slots = TurfModel.getTimeSlots();
      
      expect(slots.isNotEmpty, true);
      expect(slots.first, '06:00');
      expect(slots.last, '23:00');
    });
  });
}
