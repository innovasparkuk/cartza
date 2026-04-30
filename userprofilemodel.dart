// ─────────────────────────────────────────────
//  MODEL: UserProfile
//  Central data model for all user profile data.
//  All fields are mutable so UI can update them.
// ─────────────────────────────────────────────

class UserProfile {
  String fullName;
  String phone;
  String email;
  String dateOfBirth;
  String gender;
  String location;
  String? profileImagePath;

  UserProfile({
    this.fullName    = 'Ayesha Khan',
    this.phone       = '+92 300 1234567',
    this.email       = 'ayesha.khan@gmail.com',
    this.dateOfBirth = 'March 14, 1995',
    this.gender      = 'Female',
    this.location    = 'Islamabad, PAK',
    this.profileImagePath,
  });

  /// Returns initials for avatar fallback (max 2 chars).
  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  /// Serialise to Map for SharedPreferences storage.
  Map<String, String> toMap() => {
    'fullName': fullName,
    'phone': phone,
    'email': email,
    'dateOfBirth': dateOfBirth,
    'gender': gender,
    'location': location,
    'profileImagePath': profileImagePath ?? '',
  };

  /// Populate from Map read from SharedPreferences.
  factory UserProfile.fromMap(Map<String, String> map) => UserProfile(
    fullName:          map['fullName']    ?? 'Ayesha Khan',
    phone:             map['phone']       ?? '+92 300 1234567',
    email:             map['email']       ?? 'ayesha.khan@gmail.com',
    dateOfBirth:       map['dateOfBirth'] ?? 'March 14, 1995',
    gender:            map['gender']      ?? 'Female',
    location:          map['location']    ?? 'Islamabad, PAK',
    profileImagePath:  map['profileImagePath']?.isEmpty == true
        ? null
        : map['profileImagePath'],
  );
}