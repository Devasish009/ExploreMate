import 'package:flutter/material.dart';
import '../models/trip_model.dart';

/// Trip / itinerary service — mock data layer.
class TripService {
  TripService._();
  static final TripService instance = TripService._();

  // ── Seed data ─────────────────────────────────────────────────────────────
  static final List<TripModel> _mockTrips = [
    TripModel(
      tripId: 't001',
      userId: 'mock-uid-001',
      destination: 'Vizag',
      startDate: DateTime(2026, 4, 14),
      endDate: DateTime(2026, 4, 16),
      createdAt: DateTime.now(),
      stops: [
        // Day 1
        const TripStopModel(
          stopId: 's001',
          tripId: 't001',
          placeId: 'p007',
          placeName: 'RK Beach',
          description: 'Scenic morning walk',
          timeSlot: '9:00 AM',
          durationLabel: '1.5 hrs',
          dayIndex: 0,
          order: 0,
          icon: Icons.beach_access_rounded,
        ),
        const TripStopModel(
          stopId: 's002',
          tripId: 't001',
          placeId: 'p006',
          placeName: 'Submarine Museum',
          description: 'Hidden gem · Must visit',
          timeSlot: '11:30 AM',
          durationLabel: '2 hrs',
          dayIndex: 0,
          order: 1,
          icon: Icons.water_rounded,
        ),
        const TripStopModel(
          stopId: 's003',
          tripId: 't001',
          placeId: 'p008',
          placeName: 'Kailasagiri',
          description: 'Hill viewpoint & ropeway',
          timeSlot: '2:00 PM',
          durationLabel: '3 hrs',
          dayIndex: 0,
          order: 2,
          icon: Icons.landscape_rounded,
        ),
        const TripStopModel(
          stopId: 's004',
          tripId: 't001',
          placeId: 'p009',
          placeName: 'Jagadamba',
          description: 'Street food evening',
          timeSlot: '7:00 PM',
          durationLabel: 'Evening',
          dayIndex: 0,
          order: 3,
          icon: Icons.restaurant_rounded,
        ),
        // Day 2
        const TripStopModel(
          stopId: 's005',
          tripId: 't001',
          placeId: 'p004',
          placeName: 'Borra Caves',
          description: 'Limestone cave formations',
          timeSlot: '8:00 AM',
          durationLabel: '3 hrs',
          dayIndex: 1,
          order: 0,
          icon: Icons.terrain_rounded,
        ),
        const TripStopModel(
          stopId: 's006',
          tripId: 't001',
          placeId: 'p010',
          placeName: 'Araku Valley',
          description: 'Coffee plantations & green hills',
          timeSlot: '1:00 PM',
          durationLabel: '4 hrs',
          dayIndex: 1,
          order: 1,
          icon: Icons.forest_rounded,
        ),
        // Day 3
        const TripStopModel(
          stopId: 's007',
          tripId: 't001',
          placeId: 'p005',
          placeName: 'Yarada Beach',
          description: 'Secluded hidden beach',
          timeSlot: '9:00 AM',
          durationLabel: '2 hrs',
          dayIndex: 2,
          order: 0,
          icon: Icons.beach_access_rounded,
        ),
        const TripStopModel(
          stopId: 's008',
          tripId: 't001',
          placeId: 'p011',
          placeName: 'Bheemunipatnam',
          description: 'Dutch ruins & calm waters',
          timeSlot: '12:00 PM',
          durationLabel: '3 hrs',
          dayIndex: 2,
          order: 1,
          icon: Icons.account_balance_rounded,
        ),
      ],
    ),
  ];

  // ── Public API ─────────────────────────────────────────────────────────────

  Future<List<TripModel>> getTrips(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockTrips.where((t) => t.userId == userId).toList();
  }

  Future<TripModel?> getTripById(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockTrips.firstWhere((t) => t.tripId == tripId);
    } catch (_) {
      return null;
    }
  }

  /// Create a new trip. In Firebase: Firestore.collection('trips').add(...)
  Future<TripModel> createTrip({
    required String userId,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newTrip = TripModel(
      tripId: 'trip-${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      createdAt: DateTime.now(),
    );
    _mockTrips.add(newTrip);
    return newTrip;
  }

  /// Add a stop to an existing trip.
  Future<void> addStop(TripStopModel stop) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final trip = _mockTrips.firstWhere((t) => t.tripId == stop.tripId);
    (_mockTrips[_mockTrips.indexOf(trip)].stops as List).add(stop);
  }

  Future<void> deleteStop(String stopId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (final trip in _mockTrips) {
      trip.stops.removeWhere((s) => s.stopId == stopId);
    }
  }

  Future<void> deleteTrip(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _mockTrips.removeWhere((t) => t.tripId == tripId);
  }
}
