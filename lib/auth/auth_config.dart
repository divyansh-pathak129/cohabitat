// Auth0 configuration
class AuthConfig {
  // These are temporary test values
  static const String domain = 'cohabitat.us.auth0.com';

  // Test client ID
  static const String clientId = 'r14Y2WVxxHRAlV6TDWmletBbQlKAyF4t';
  // We must match the package name in the build.gradle file
  static const String redirectUri =
      'com.cohabitat.cohabitat://cohabitat.us.auth0.com/android/com.cohabitat.cohabitat/callback';

  // Optional API audience - can be empty for now
  static const String audience = '';
}
