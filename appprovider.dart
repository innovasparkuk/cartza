// ─────────────────────────────────────────────
//  PROVIDER: AppProvider
//  Single ChangeNotifier that manages:
//    • UserProfile (persisted)
//    • ThemeMode   (persisted)
//    • Locale      (persisted)
//
//  Usage in main.dart:
//    ChangeNotifierProvider(create: (_) => AppProvider()..init())
// ─────────────────────────────────────────────

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page.dart';
import 'Localstorageservice.dart';
import 'user_profile.dart';
class AppProvider extends ChangeNotifier {
  late LocalStorageService _storage;

  // ── State ──────────────────────────────────
  UserProfile _profile = UserProfile();
  ThemeMode   _themeMode = ThemeMode.light;
  Locale      _locale    = const Locale('en');
  bool        _initialised = false;

  // ── Getters ────────────────────────────────
  UserProfile get profile    => _profile;
  ThemeMode   get themeMode  => _themeMode;
  Locale      get locale     => _locale;
  bool        get isReady    => _initialised;

  // ── Init (call once, after ChangeNotifierProvider) ──
  Future<void> init() async {
    _storage   = await LocalStorageService.getInstance();
    _profile   = _storage.loadProfile();
    _themeMode = _modeFromString(_storage.loadTheme());
    _locale    = Locale(_storage.loadLanguage());
    _initialised = true;
    notifyListeners();
  }

  // ── Profile mutations ──────────────────────
  Future<void> updateField(String field, String value) async {
    switch (field) {
      case 'fullName':    _profile.fullName    = value; break;
      case 'phone':       _profile.phone       = value; break;
      case 'email':       _profile.email       = value; break;
      case 'dateOfBirth': _profile.dateOfBirth = value; break;
      case 'gender':      _profile.gender      = value; break;
      case 'location':    _profile.location    = value; break;
    }
    await _storage.saveProfile(_profile);
    notifyListeners();
  }

  Future<void> pickProfileImage(ImageSource source) async {
    final picked = await ImagePicker()
        .pickImage(source: source, imageQuality: 70);
    if (picked != null) {
      _profile.profileImagePath = picked.path;
      await _storage.saveImagePath(picked.path);
      notifyListeners();
    }
  }

  // ── Theme ──────────────────────────────────
  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _storage.saveTheme(_modeToString(mode));
    notifyListeners();
  }

  // ── Language ───────────────────────────────
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _storage.saveLanguage(locale.languageCode);
    notifyListeners();
  }

  // ── Helpers ────────────────────────────────
  ThemeMode _modeFromString(String s) {
    switch (s) {
      case 'dark':   return ThemeMode.dark;
      case 'system': return ThemeMode.system;
      default:       return ThemeMode.light;
    }
  }

  String _modeToString(ThemeMode m) {
    switch (m) {
      case ThemeMode.dark:   return 'dark';
      case ThemeMode.system: return 'system';
      default:               return 'light';
    }
  }
}