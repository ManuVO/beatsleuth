import 'package:flutter/material.dart';

TextTheme circularStdTextTheme() {
  return TextTheme(
    displayLarge: const TextStyle(fontFamily: 'CircularStd', fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: const TextStyle(fontFamily: 'CircularStd', fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: const TextStyle(fontFamily: 'CircularStd', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: const TextStyle(fontFamily: 'CircularStd', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle(fontFamily: 'CircularStd', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: const TextStyle(fontFamily: 'CircularStd', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: const TextStyle(fontFamily: 'CircularStd', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: const TextStyle(fontFamily: 'CircularStd', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: const TextStyle(fontFamily: 'CircularStd', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontFamily: 'CircularStd', fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey[300]),
    bodyMedium: TextStyle(fontFamily: 'CircularStd', fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[300]),
    bodySmall: TextStyle(fontFamily: 'CircularStd', fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[300]),
    labelLarge: const TextStyle(fontFamily: 'CircularStd', fontSize: 18, fontWeight: FontWeight.normal, color: Color(0xFF8c8c8c)),
    labelMedium: const TextStyle(fontFamily: 'CircularStd', fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF8c8c8c)),
    labelSmall: const TextStyle(fontFamily: 'CircularStd', fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF8c8c8c)),
  );
}

Color backgroundColor({double? opacity}) {
  return const Color(0xFF121212).withOpacity(opacity ?? 1.0);
}

Color navBarColor({double? opacity}) {
  return const Color(0xFF212121).withOpacity(opacity ?? 1.0);
}