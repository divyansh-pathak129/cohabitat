class UserProfile {
  final String id;
  final String? name;
  final String? email;
  final String? picture;

  // Add additional user properties as needed
  final String? phoneNumber;
  final String? flatNumber;
  final DateTime? memberSince;

  UserProfile({
    required this.id,
    this.name,
    this.email,
    this.picture,
    this.phoneNumber,
    this.flatNumber,
    this.memberSince,
  });

  factory UserProfile.fromAuth0User(dynamic auth0User) {
    return UserProfile(
      id: auth0User.sub ?? '',
      name: auth0User.name,
      email: auth0User.email,
      picture: auth0User.pictureUrl,
      // Additional fields would need to be populated from user_metadata
      // or app_metadata in Auth0, or from your backend
      phoneNumber: null,
      flatNumber: null,
      memberSince: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'picture': picture,
    'phoneNumber': phoneNumber,
    'flatNumber': flatNumber,
    'memberSince': memberSince?.toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      picture: json['picture'],
      phoneNumber: json['phoneNumber'],
      flatNumber: json['flatNumber'],
      memberSince:
          json['memberSince'] != null
              ? DateTime.parse(json['memberSince'])
              : null,
    );
  }
}
