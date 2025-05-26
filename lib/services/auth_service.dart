import 'dart:convert';
import 'package:auth0_flutter/auth0_flutter.dart' as auth0;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../auth/auth_config.dart';

class AuthService extends ChangeNotifier {
  late auth0.Auth0 _auth0;
  Map<String, dynamic>? _userProfile;
  String? _accessToken;
  bool _isLoading = false;
  String? _error;

  // Secure storage for tokens
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Map<String, dynamic>? get userProfile => _userProfile;
  String? get accessToken => _accessToken;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _userProfile != null && _accessToken != null;
  String? get error => _error;

  AuthService() {
    _auth0 = auth0.Auth0(AuthConfig.domain, AuthConfig.clientId);
    _checkPersistedSession();
  }

  // Check if we have a stored session
  Future<void> _checkPersistedSession() async {
    _isLoading = true;
    notifyListeners();

    try {
      final storedToken = await _secureStorage.read(key: 'access_token');
      final storedUserData = await _secureStorage.read(key: 'user_profile');
      if (storedToken != null && storedUserData != null) {
        _accessToken = storedToken;

        // Parse stored user profile
        try {
          final userData = json.decode(storedUserData);
          _userProfile = userData;
        } catch (e) {
          debugPrint("Error parsing stored user profile: $e");
        }

        notifyListeners();
      }
    } catch (e) {
      _error = "Failed to restore session";
      debugPrint("Error restoring authentication session: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login with Auth0
  Future<void> login() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Using custom scheme for authentication
      final credentials = await _auth0
          .webAuthentication(scheme: 'com.cohabitat.cohabitat')
          .login(
            audience: AuthConfig.audience,
            // redirectUrl is managed by the SDK when scheme is provided
            scopes: {'openid', 'profile', 'email', 'offline_access'},
          );

      _accessToken = credentials.accessToken;
      // Use Auth0 user data directly
      final user = credentials.user;
      _userProfile = {
        'id': user.sub ?? '',
        'name': user.name != null ? user.name : 'User',
        'email': user.email != null ? user.email : '',
        'picture': user.pictureUrl != null ? user.pictureUrl.toString() : '',
        // Default values for demo
        'phoneNumber': '+1 (555) 123-4567',
        'flatNumber': 'A-101',
        'memberSince': DateTime.now().toString(),
      };

      // Store session
      await _secureStorage.write(
        key: 'access_token',
        value: credentials.accessToken,
      );
      if (_userProfile != null) {
        await _secureStorage.write(
          key: 'user_profile',
          value: json.encode(_userProfile),
        );
      }
    } catch (e) {
      _error = "Failed to login";
      debugPrint("Error during login: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout from Auth0
  Future<void> logout() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Using custom scheme for logout
      await _auth0
          .webAuthentication(scheme: 'com.cohabitat.cohabitat')
          .logout();

      _accessToken = null;
      _userProfile = null;

      // Clear stored session
      await _secureStorage.delete(key: 'access_token');
      await _secureStorage.delete(key: 'user_profile');
    } catch (e) {
      _error = "Failed to logout";
      debugPrint("Error during logout: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
