import '../models/translation_model.dart';

/// Translator service — mock translation engine.
/// Migration: swap _mockTranslate() with Google Cloud Translation API call.
class TranslatorService {
  TranslatorService._();
  static final TranslatorService instance = TranslatorService._();

  // Simple mock translation dictionary
  static const Map<String, Map<String, String>> _dict = {
    'English': {
      'Hello': 'హలో',                        // Telugu
      'Thank you': 'ధన్యవాదాలు',
      'Help me': 'నాకు సహాయం చేయండి',
      'How much?': 'ఎంత ఖర్చు అవుతుంది?',
      'Where is?': 'ఎక్కడ ఉంది?',
      'Good morning': 'శుభోదయం',
      'Good night': 'శుభ రాత్రి',
    }
  };

  final List<TranslationModel> _history = [
    TranslationModel(
      id: 'tr001',
      userId: 'mock-uid-001',
      sourceText: 'Where is the nearest bus stop?',
      translatedText: 'సమీప బస్ స్టాప్ ఎక్కడ ఉంది?',
      fromLang: 'English',
      toLang: 'Telugu',
      savedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    TranslationModel(
      id: 'tr002',
      userId: 'mock-uid-001',
      sourceText: 'How much does this cost?',
      translatedText: 'దీని ధర ఎంత?',
      fromLang: 'English',
      toLang: 'Telugu',
      savedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  /// Translate text from [fromLang] to [toLang].
  /// Returns the translated string.
  Future<String> translate(
      String text, String fromLang, String toLang) async {
    await Future.delayed(const Duration(milliseconds: 700));

    // Check mock dictionary first
    final dict = _dict[fromLang];
    if (dict != null && dict.containsKey(text)) {
      return dict[text]!;
    }

    // Fallback placeholder (replace with API call)
    return '[$toLang translation of: "$text"]';
  }

  /// Save a translation to history (mock: in-memory; replace with Firestore).
  Future<void> saveToHistory(TranslationModel translation) async {
    await Future.delayed(const Duration(milliseconds: 250));
    _history.insert(0, translation);
  }

  /// Fetch saved translation history for a user.
  Future<List<TranslationModel>> getHistory(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _history.where((t) => t.userId == userId).toList();
  }

  Future<void> deleteHistory(String translationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _history.removeWhere((t) => t.id == translationId);
  }
}
