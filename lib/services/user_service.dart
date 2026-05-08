import '../models/user_model.dart';

/// User profile & XP service — mock data.
/// Migration: replace in-memory map with Firestore reads/writes.
class UserService {
  UserService._();
  static final UserService instance = UserService._();

  // ── Mock user store ───────────────────────────────────────────────────────
  static final Map<String, UserModel> _profiles = {
    'mock-uid-001': UserModel(
      uid: 'mock-uid-001',
      name: 'Arjun Kumar',
      email: 'arjun@example.com',
      level: 4,
      xp: 1240,
      badges: const ['Gem Hunter', 'Foodie', 'Navigator'],
      createdAt: DateTime(2024, 1, 15),
    ),
    'mock-uid-002': UserModel(
      uid: 'mock-uid-002',
      name: 'Priya Sharma',
      email: 'priya@example.com',
      level: 6,
      xp: 2850,
      badges: const ['Gem Hunter', 'Wanderlust', 'Linguist', 'Foodie'],
      createdAt: DateTime(2023, 11, 20),
    ),
    'mock-uid-003': UserModel(
      uid: 'mock-uid-003',
      name: 'Ravi Teja',
      email: 'ravi@example.com',
      level: 3,
      xp: 650,
      badges: const ['Navigator', 'Foodie'],
      createdAt: DateTime(2024, 3, 5),
    ),
  };

  // ── Public API ─────────────────────────────────────────────────────────────

  Future<UserModel?> getUserProfile(String uid) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _profiles[uid];
  }

  Future<void> updateProfile(UserModel updated) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _profiles[updated.uid] = updated;
  }

  /// Award XP and level up if threshold is crossed.
  Future<UserModel?> updateXP(String uid, int delta) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = _profiles[uid];
    if (user == null) return null;

    final newXp = user.xp + delta;
    final newLevel = _calculateLevel(newXp);
    final updated = user.copyWith(xp: newXp, level: newLevel);
    _profiles[uid] = updated;
    return updated;
  }

  /// Returns the leaderboard sorted by XP descending.
  Future<List<UserModel>> getLeaderboard() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final list = _profiles.values.toList()
      ..sort((a, b) => b.xp.compareTo(a.xp));
    return list;
  }

  Future<void> addBadge(String uid, String badge) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final user = _profiles[uid];
    if (user == null) return;
    if (!user.badges.contains(badge)) {
      _profiles[uid] = user.copyWith(badges: [...user.badges, badge]);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// XP thresholds per level (level n requires n*500 XP).
  int _calculateLevel(int xp) {
    int level = 1;
    while (xp >= level * 500) {
      level++;
    }
    return level;
  }

  /// Progress fraction [0..1] within the current level.
  double levelProgress(UserModel user) {
    final lower = (user.level - 1) * 500;
    final upper = user.level * 500;
    return ((user.xp - lower) / (upper - lower)).clamp(0.0, 1.0);
  }
}
