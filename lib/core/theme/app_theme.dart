import 'package:flutter/material.dart';

class AppTheme {
  // ── Palette ────────────────────────────────────────────────────
  static const Color _lightBg = Color(0xFFF2F7F4);        // soft sage-white
  static const Color _darkBg = Color(0xFF0B1A16);         // deep forest dark
  static const Color _primaryGreen = Color(0xFF2E7D52);   // rich leaf green
  static const Color _lightText = Color(0xFF1A2E25);      // near-black green-tinted
  static const Color _lightSubtext = Color(0xFF4A6355);   // muted forest green

  // ── Light Theme ────────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryGreen,
          brightness: Brightness.light,
          primary: _primaryGreen,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: _lightText,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: _lightBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: _lightText,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _lightText,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: _lightText),
          displayMedium: TextStyle(color: _lightText),
          displaySmall: TextStyle(color: _lightText),
          headlineLarge: TextStyle(color: _lightText),
          headlineMedium: TextStyle(color: _lightText),
          headlineSmall: TextStyle(color: _lightText),
          titleLarge: TextStyle(color: _lightText, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(color: _lightText, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(color: _lightText),
          bodyLarge: TextStyle(color: _lightText),
          bodyMedium: TextStyle(color: _lightSubtext),
          bodySmall: TextStyle(color: _lightSubtext),
          labelLarge: TextStyle(color: _lightText, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: _lightSubtext),
          labelSmall: TextStyle(color: _lightSubtext),
        ),
        cardColor: Colors.white,
        dividerColor: const Color(0xFF2E7D52).withValues(alpha: 0.12),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: _primaryGreen.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: _primaryGreen.withValues(alpha: 0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _primaryGreen, width: 1.5),
          ),
          labelStyle: const TextStyle(color: _lightSubtext),
          hintStyle: TextStyle(color: _lightSubtext.withValues(alpha: 0.6)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? _primaryGreen : Colors.grey.shade400,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? _primaryGreen.withValues(alpha: 0.3) : Colors.grey.shade200,
          ),
        ),
      );

  // ── Dark Theme ─────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryGreen,
          brightness: Brightness.dark,
          primary: const Color(0xFF4CAF82),
          onPrimary: Colors.white,
          surface: const Color(0xFF132218),
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: _darkBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardColor: Colors.transparent,
        dividerColor: Colors.white.withValues(alpha: 0.1),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.07),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF4CAF82), width: 1.5),
          ),
          labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF82),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
}
