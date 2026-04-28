// ─────────────────────────────────────────────
//  SERVICE: LocalStorageService
//  Wraps SharedPreferences for all persistence.
//  Keys are namespaced with a prefix to avoid clashes.
// ─────────────────────────────────────────────

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cartza_user/profile_page.dart';
import 'user_profile.dart';
class LocalStorageService {
  // ── Singleton ──────────────────────────────
  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // ── Keys ───────────────────────────────────
  static const String _kPrefix       = 'cartza_';
  static const String _kFullName     = '${_kPrefix}fullName';
  static const String _kPhone        = '${_kPrefix}phone';
  static const String _kEmail        = '${_kPrefix}email';
  static const String _kDob          = '${_kPrefix}dob';
  static const String _kGender       = '${_kPrefix}gender';
  static const String _kLocation     = '${_kPrefix}location';
  static const String _kImagePath    = '${_kPrefix}imagePath';
  static const String _kTheme        = '${_kPrefix}theme';
  static const String _kLang         = '${_kPrefix}lang';

  // ── Profile ────────────────────────────────
  Future<void> saveProfile(UserProfile profile) async {
    final p = _prefs!;
    await Future.wait([
      p.setString(_kFullName,  profile.fullName),
      p.setString(_kPhone,     profile.phone),
      p.setString(_kEmail,     profile.email),
      p.setString(_kDob,       profile.dateOfBirth),
      p.setString(_kGender,    profile.gender),
      p.setString(_kLocation,  profile.location),
      p.setString(_kImagePath, profile.profileImagePath ?? ''),
    ]);
  }

  UserProfile loadProfile() => UserProfile(
    fullName:         _prefs!.getString(_kFullName)  ?? 'Ayesha Khan',
    phone:            _prefs!.getString(_kPhone)     ?? '+92 300 1234567',
    email:            _prefs!.getString(_kEmail)     ?? 'ayesha.khan@gmail.com',
    dateOfBirth:      _prefs!.getString(_kDob)       ?? 'March 14, 1995',
    gender:           _prefs!.getString(_kGender)    ?? 'Female',
    location:         _prefs!.getString(_kLocation)  ?? 'Islamabad, PAK',
    profileImagePath: _prefs!.getString(_kImagePath)?.isEmpty == true
        ? null
        : _prefs!.getString(_kImagePath),
  );

  Future<void> saveImagePath(String path) =>
      _prefs!.setString(_kImagePath, path);

  // ── Theme ──────────────────────────────────
  /// Stores 'light' | 'dark' | 'system'
  Future<void> saveTheme(String mode) =>
      _prefs!.setString(_kTheme, mode);

  String loadTheme() => _prefs!.getString(_kTheme) ?? 'light';

  // ── Language ───────────────────────────────
  /// Stores language code e.g. 'en' | 'ur'
  Future<void> saveLanguage(String langCode) =>
      _prefs!.setString(_kLang, langCode);

  String loadLanguage() => _prefs!.getString(_kLang) ?? 'en';
}