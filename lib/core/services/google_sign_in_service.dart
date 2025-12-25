import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/auth_constants.dart';

/// Service for handling Google Sign-In
class GoogleSignInService {
  late final GoogleSignIn _googleSignIn;

  GoogleSignInService() {
    _googleSignIn = GoogleSignIn(
      // Always provide clientId for all platforms (required for web and iOS)
      clientId: AuthConstants.googleWebClientId,
      serverClientId: AuthConstants.googleWebClientId,
      scopes: AuthConstants.googleScopes,
    );
  }

  /// Sign in with Google
  /// Returns the ID token for backend verification
  Future<GoogleSignInResult> signIn() async {
    try {
      // Sign out first to ensure fresh login
      await _googleSignIn.signOut();
      
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      
      if (account == null) {
        return GoogleSignInResult.cancelled();
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      
      if (auth.idToken == null) {
        return GoogleSignInResult.error('Failed to get ID token');
      }

      return GoogleSignInResult.success(
        idToken: auth.idToken!,
        accessToken: auth.accessToken,
        email: account.email,
        displayName: account.displayName,
        photoUrl: account.photoUrl,
      );
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      return GoogleSignInResult.error(e.toString());
    }
  }

  /// Sign out from Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  /// Disconnect Google account (revokes access)
  Future<void> disconnect() async {
    await _googleSignIn.disconnect();
  }

  /// Check if user is currently signed in
  Future<bool> isSignedIn() async {
    return _googleSignIn.isSignedIn();
  }

  /// Get current signed-in account
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}

/// Result class for Google Sign-In
class GoogleSignInResult {
  final bool isSuccess;
  final bool isCancelled;
  final String? error;
  final String? idToken;
  final String? accessToken;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  GoogleSignInResult._({
    required this.isSuccess,
    required this.isCancelled,
    this.error,
    this.idToken,
    this.accessToken,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory GoogleSignInResult.success({
    required String idToken,
    String? accessToken,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return GoogleSignInResult._(
      isSuccess: true,
      isCancelled: false,
      idToken: idToken,
      accessToken: accessToken,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  factory GoogleSignInResult.cancelled() {
    return GoogleSignInResult._(
      isSuccess: false,
      isCancelled: true,
    );
  }

  factory GoogleSignInResult.error(String message) {
    return GoogleSignInResult._(
      isSuccess: false,
      isCancelled: false,
      error: message,
    );
  }
}

/// Provider for GoogleSignInService
final googleSignInServiceProvider = Provider<GoogleSignInService>((ref) {
  return GoogleSignInService();
});