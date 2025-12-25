/// Authentication Constants for VidiBattle
/// Contains OAuth client IDs and configuration
class AuthConstants {
  AuthConstants._();

  // ============ GOOGLE OAUTH CONFIGURATION ============
  
  /// Google OAuth Web Client ID (used for backend verification)
  /// This is the "Web application" client ID from Google Cloud Console
  static const String googleWebClientId = 
      '937435569832-71ikcpad08a12460mckr8unerjn1j4rs.apps.googleusercontent.com';
  
  /// Google OAuth iOS Client ID
  /// This is the "iOS" client ID from Google Cloud Console
  static const String googleIosClientId = 
      '937435569832-26pc272h78pqkg0ekdcp2s8plg43kfd3.apps.googleusercontent.com';
  
  /// Google OAuth Android Client ID
  /// Note: For Android, you typically need to create a separate OAuth client
  /// with your app's SHA-1 fingerprint. For now, we use the web client ID
  /// which works for development. Create an Android OAuth client for production.
  static const String googleAndroidClientId = googleWebClientId;
  
  /// Google Sign-In scopes
  static const List<String> googleScopes = [
    'email',
    'profile',
    'openid',
  ];

  // ============ GOOGLE PROJECT INFO ============
  
  /// Google Cloud Project ID
  static const String googleProjectId = 'vibtrix';

  // ============ API ENDPOINTS ============
  
  /// Google Sign-In endpoint for mobile
  static const String googleMobileAuthEndpoint = '/auth/google/mobile';
  
  /// Social login endpoint
  static const String socialLoginEndpoint = '/auth/social';
}