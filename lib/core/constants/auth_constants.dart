/// Authentication Constants for VidiBattle
/// Contains OAuth client IDs and configuration
class AuthConstants {
  AuthConstants._();

  // ============ GOOGLE OAUTH CONFIGURATION ============
  
  /// Google OAuth Web Client ID (used for backend verification and as serverClientId)
  /// This is the "Web application" client ID from Google Cloud Console
  static const String googleWebClientId = 
      '937435569832-71ikcpad08a12460mckr8unerjn1j4rs.apps.googleusercontent.com';
  
  /// Google OAuth iOS Client ID
  /// This is the "iOS" client ID from Google Cloud Console
  /// Note: Using the Android client ID for now - create iOS client if needed
  static const String googleIosClientId = 
      '937435569832-26pc272h78pqkg0ekdcp2s8plg43kfd3.apps.googleusercontent.com';
  
  /// Google OAuth Android Client ID
  /// This is the "Android" client ID from Google Cloud Console
  /// Created with package name: com.rektech.vibtrix
  /// SHA-1: 75:0A:F8:0B:7F:31:44:29:43:10:B6:3C:B4:BE:89:20:E1:63:68:E5
  static const String googleAndroidClientId = 
      '937435569832-26pc272h78pqkg0ekdcp2s8plg43kfd3.apps.googleusercontent.com';
  
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