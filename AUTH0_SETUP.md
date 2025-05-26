# Setting up Auth0 Authentication in Cohabitat

To complete setting up Auth0 in your Cohabitat app, follow these steps:

## 1. Create an Auth0 Account and Application

1. Go to [Auth0's website](https://auth0.com/) and create an account.
2. Create a new Native application for your Flutter app.
3. Take note of your:
   - Domain (e.g., `cohabitat.us.auth0.com`)
   - Client ID

## 2. Update Auth0 Configuration

Open the file `lib/auth/auth_config.dart` and replace the placeholder values:

```dart
// Auth0 configuration
class AuthConfig {
  // Replace with your Auth0 domain
  static const String domain = 'YOUR_AUTH0_DOMAIN'; // e.g. 'cohabitat.us.auth0.com'
  
  // Replace with your Auth0 client ID
  static const String clientId = 'YOUR_AUTH0_CLIENT_ID';
  
  // Callback URL for Auth0 authentication
  static const String redirectUri = 'com.example.cohabitat://YOUR_AUTH0_DOMAIN/android/com.example.cohabitat/callback';
  
  // Audience for API calls (optional)
  static const String audience = 'https://cohabitat-api.example.com';
}
```

## 3. Configure Callback URLs in Auth0 Dashboard

In the Auth0 dashboard for your application:

1. Add the following to "Allowed Callback URLs":
   ```
   com.cohabitat.cohabitat://dev-example.us.auth0.com/android/com.cohabitat.cohabitat/callback
   ```

2. Add the same URL to "Allowed Logout URLs"

## 4. Update Android Package Name

If your application's package name is not `com.example.cohabitat`, update all instances of it in:

1. The `android/app/build.gradle` file
2. The `AndroidManifest.xml` file
3. The `AuthConfig.redirectUri` value

## 5. Test Your Implementation

Run your application with:

```
flutter run
```

Click on the login button to test the Auth0 authentication flow.

## Auth0 Features Implemented

1. **Modern Login Screen**: Clean UI with animated transitions
2. **Token Management**: Secure storage of access tokens
3. **Profile Management**: Display user profile information
4. **Session Persistence**: Stay logged in between app restarts
5. **Logout Functionality**: Secure session termination

## Additional Resources

* [Auth0 Flutter SDK Documentation](https://auth0.com/docs/quickstart/native/flutter)
* [Auth0 Flutter SDK GitHub Repository](https://github.com/auth0/auth0-flutter)
