import '../models/user_model.dart';

/// Authentication service — runs in mock mode by default.
/// Swap the implementations inside each method for Firebase Auth when ready.
///
/// Firebase migration path:
///   1. Add firebase_core, firebase_auth to pubspec.yaml
///   2. Run `flutterfire configure`
///   3. Replace _MockStore with FirebaseAuth + Firestore calls
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  // ── Mock state ────────────────────────────────────────────────────────────
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;

  // ── Mock user store ───────────────────────────────────────────────────────
  static final Map<String, Map<String, dynamic>> _mockStore = {
    'arjun@example.com': {
      'password': 'pass1234',
      'uid': 'mock-uid-001',
      'name': 'Arjun Kumar',
      'email': 'arjun@example.com',
      'level': 4,
      'xp': 1240,
      'badges': ['Gem Hunter', 'Foodie', 'Navigator'],
      'createdAt': '2024-01-15T00:00:00.000Z',
    },
  };

  /// Sign in with email + password.
  /// Returns null on success; error message on failure.
  Future<String?> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    final entry = _mockStore[email.toLowerCase()];
    if (entry == null || entry['password'] != password) {
      return 'Invalid email or password.';
    }
    _currentUser = UserModel.fromMap(entry['uid'] as String, entry);
    return null; // success
  }

  /// Register a new account.
  Future<String?> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_mockStore.containsKey(email.toLowerCase())) {
      return 'An account with this email already exists.';
    }
    final uid = 'mock-uid-${DateTime.now().millisecondsSinceEpoch}';
    _mockStore[email.toLowerCase()] = {
      'password': password,
      'uid': uid,
      'name': name,
      'email': email,
      'level': 1,
      'xp': 0,
      'badges': <String>[],
      'createdAt': DateTime.now().toIso8601String(),
    };
    _currentUser = UserModel.fromMap(uid, _mockStore[email.toLowerCase()]!);
    return null; // success
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  // ── Guest / auto-sign-in for demo ─────────────────────────────────────────
  Future<void> signInAsGuest() async {
    await Future.delayed(const Duration(milliseconds: 400));
    const uid = 'guest-uid';
    _currentUser = UserModel(
      uid: uid,
      name: 'Guest Explorer',
      email: 'guest@exploremate.app',
      level: 1,
      xp: 0,
      createdAt: DateTime.now(),
    );
  }
}
