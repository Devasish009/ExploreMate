import 'package:flutter/material.dart';
import '../models/place_model.dart';

/// Places / POI service — mock data layer.
/// Replace _mockPlaces with Firestore queries when Firebase is configured.
class PlaceService {
  PlaceService._();
  static final PlaceService instance = PlaceService._();

  // ── Seed data ─────────────────────────────────────────────────────────────
  static final List<PlaceModel> _mockPlaces = [
    const PlaceModel(
      placeId: 'p001',
      name: 'Lotus Lake Viewpoint',
      type: 'Hidden gem',
      tag: 'Gem',
      distKm: 2.3,
      lat: 17.6900,
      lng: 83.2100,
      isHiddenGem: true,
      icon: Icons.water_rounded,
      description: 'A serene lotus lake surrounded by hills. '
          'Best visited at sunrise for spectacular reflections.',
      rating: 4.8,
    ),
    const PlaceModel(
      placeId: 'p002',
      name: 'Old Quarter Market',
      type: 'Cultural',
      tag: 'Popular',
      distKm: 3.7,
      lat: 17.7150,
      lng: 83.2950,
      isHiddenGem: false,
      icon: Icons.store_rounded,
      description: 'Vibrant street market with handmade crafts and local food.',
      rating: 4.3,
    ),
    const PlaceModel(
      placeId: 'p003',
      name: 'Sunset Cliffside',
      type: 'Scenic',
      tag: 'Must-see',
      distKm: 6.1,
      lat: 17.6750,
      lng: 83.3200,
      isHiddenGem: false,
      icon: Icons.landscape_rounded,
      description: 'Dramatic cliff overlooking the Bay of Bengal.',
      rating: 4.9,
    ),
    const PlaceModel(
      placeId: 'p004',
      name: 'Borra Caves',
      type: 'Nature',
      tag: 'Gem',
      distKm: 92.0,
      lat: 18.0756,
      lng: 83.1403,
      isHiddenGem: true,
      icon: Icons.terrain_rounded,
      description: 'Ancient limestone caves with million-year-old formations.',
      rating: 4.7,
    ),
    const PlaceModel(
      placeId: 'p005',
      name: 'Yarada Beach',
      type: 'Beach',
      tag: 'Gem',
      distKm: 15.0,
      lat: 17.6100,
      lng: 83.2300,
      isHiddenGem: true,
      icon: Icons.beach_access_rounded,
      description: 'Secluded beach nestled between hills — rarely crowded.',
      rating: 4.6,
    ),
    const PlaceModel(
      placeId: 'p006',
      name: 'Submarine Museum',
      type: 'Museum',
      tag: 'Must-see',
      distKm: 4.5,
      lat: 17.7100,
      lng: 83.3100,
      isHiddenGem: false,
      icon: Icons.water_rounded,
      description: 'A decommissioned INS Kursura submarine now a museum.',
      rating: 4.4,
    ),
  ];

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Fetch all places, optionally filtered to hidden gems only.
  Future<List<PlaceModel>> getPlaces({bool gemsOnly = false}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (gemsOnly) {
      return _mockPlaces.where((p) => p.isHiddenGem).toList();
    }
    return List.unmodifiable(_mockPlaces);
  }

  /// Simple text search against name and type.
  Future<List<PlaceModel>> searchPlaces(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final q = query.toLowerCase();
    return _mockPlaces
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.type.toLowerCase().contains(q) ||
            p.tag.toLowerCase().contains(q))
        .toList();
  }

  /// Fetch a single place by id.
  Future<PlaceModel?> getPlaceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockPlaces.firstWhere((p) => p.placeId == id);
    } catch (_) {
      return null;
    }
  }

  /// Mark a place as visited and award XP.
  /// In Firebase: update `userProgress/{uid_placeId}` document.
  Future<void> markVisited(String placeId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // TODO: Firestore → set userProgress doc, call UserService.updateXP()
  }
}
