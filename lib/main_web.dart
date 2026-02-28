/// Platform-specific initialization for Web
Future<void> initializePlatform() async {
  // Web platform doesn't need sqflite initialization
  // All data is stored in localStorage
}
