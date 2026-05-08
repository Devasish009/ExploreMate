import '../models/audio_tour_model.dart';

/// Audio tour service — mock data.
/// Migration: swap getAudioUrl() with Firebase Storage URL resolution.
class AudioTourService {
  AudioTourService._();
  static final AudioTourService instance = AudioTourService._();

  static final List<AudioTourModel> _mockTours = [
    const AudioTourModel(
      tourId: 'at001',
      placeId: 'p006',
      placeName: 'Submarine Museum',
      language: 'English',
      durationSec: 720,
      audioUrl: 'assets/tours/submarine_en.mp3',
      rating: 4.7,
      playCount: 1240,
    ),
    const AudioTourModel(
      tourId: 'at002',
      placeId: 'p003',
      placeName: 'Sunset Cliffside',
      language: 'English',
      durationSec: 540,
      audioUrl: 'assets/tours/cliffside_en.mp3',
      rating: 4.9,
      playCount: 870,
    ),
    const AudioTourModel(
      tourId: 'at003',
      placeId: 'p004',
      placeName: 'Borra Caves',
      language: 'English',
      durationSec: 900,
      audioUrl: 'assets/tours/borra_en.mp3',
      rating: 4.8,
      playCount: 2100,
    ),
    const AudioTourModel(
      tourId: 'at004',
      placeId: 'p004',
      placeName: 'Borra Caves',
      language: 'Telugu',
      durationSec: 870,
      audioUrl: 'assets/tours/borra_te.mp3',
      rating: 4.6,
      playCount: 560,
    ),
    const AudioTourModel(
      tourId: 'at005',
      placeId: 'p001',
      placeName: 'Lotus Lake Viewpoint',
      language: 'English',
      durationSec: 420,
      audioUrl: 'assets/tours/lotus_en.mp3',
      rating: 4.5,
      playCount: 320,
    ),
  ];

  /// Get all tours for a given place.
  Future<List<AudioTourModel>> getToursForPlace(String placeId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockTours.where((t) => t.placeId == placeId).toList();
  }

  /// Get tours available in a specific language.
  Future<List<AudioTourModel>> getToursByLanguage(String language) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _mockTours
        .where((t) => t.language.toLowerCase() == language.toLowerCase())
        .toList();
  }

  /// Get all tours (for the Audio Tour screen listing).
  Future<List<AudioTourModel>> getAllTours() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return List.unmodifiable(_mockTours);
  }

  /// Resolve audio URL (mock returns asset path; replace with Storage.ref().getDownloadURL()).
  Future<String> getAudioUrl(String tourId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockTours.firstWhere((t) => t.tourId == tourId).audioUrl;
    } catch (_) {
      return '';
    }
  }

  /// Increment play count — in Firebase: FieldValue.increment(1)
  Future<void> incrementPlayCount(String tourId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    // TODO: Firestore update
  }
}
