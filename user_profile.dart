import 'package:image_picker/image_picker.dart';
class UserProfile {
  String fullName;
  String phone;
  String email;
  String dateOfBirth;
  String gender;
  String location;
  String? profileImagePath;

  UserProfile({
    this.fullName = '',
    this.phone = '',
    this.email = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.location = '',
    this.profileImagePath,
  });

  // Add this getter to calculate initials
  String get initials {
    if (fullName.trim().isEmpty) return 'U';

    final nameParts = fullName.trim().split(' ');

    // Takes the first letter of the first name and last name (if available)
    final first = nameParts[0].isNotEmpty ? nameParts[0][0] : '';
    final last = nameParts.length > 1 ? nameParts[nameParts.length - 1][0] : '';

    return (first + last).toUpperCase();
  }
}