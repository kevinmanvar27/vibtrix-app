import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'core/storage/local_storage.dart';
import 'firebase_options.dart';

/// Application entry point
/// 
/// Initializes all required services before running the app:
/// - Firebase (for push notifications and analytics)
/// - Local storage (SharedPreferences)
/// - System UI configuration
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Run initialization in a zone to catch errors
  await runZonedGuarded(
    () async {
      // Initialize services in parallel where possible
      await Future.wait([
        _initializeFirebase(),
        _initializeStorage(),
      ]);
      
      // Configure system UI
      _configureSystemUI();
      
      // Set up error handling
      _setupErrorHandling();
      
      // Run the app with Riverpod
      runApp(
        const ProviderScope(
          child: VidiBattleApp(),
        ),
      );
    },
    (error, stackTrace) {
      // Global error handler for uncaught errors
      if (kDebugMode) {
        print('Uncaught error: $error');
        print('Stack trace: $stackTrace');
      }
      // In production, you might want to log this to a crash reporting service
    },
  );
}

/// Initialize Firebase services
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('✓ Firebase initialized');
    }
  } catch (e) {
    if (kDebugMode) {
      print('✗ Firebase initialization failed: $e');
    }
    // Firebase is optional for basic app functionality
    // Continue even if it fails
  }
}

/// Initialize local storage
Future<void> _initializeStorage() async {
  try {
    await LocalStorage.init();
    if (kDebugMode) {
      print('✓ Local storage initialized');
    }
  } catch (e) {
    if (kDebugMode) {
      print('✗ Local storage initialization failed: $e');
    }
    rethrow; // Storage is critical, rethrow
  }
}

/// Configure system UI appearance
void _configureSystemUI() {
  // Set preferred orientations (portrait only for this app)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style (will be updated by theme)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Enable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  
  if (kDebugMode) {
    print('✓ System UI configured');
  }
}

/// Set up global error handling
void _setupErrorHandling() {
  // Handle Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      // In debug mode, print to console
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In release mode, log to crash reporting service
      // TODO: Integrate with Firebase Crashlytics or similar
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    }
  };
  
  // Handle errors in the platform dispatcher
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      print('Platform error: $error');
      print('Stack trace: $stack');
    }
    // Return true to indicate the error was handled
    return true;
  };
  
  if (kDebugMode) {
    print('✓ Error handling configured');
  }
}
