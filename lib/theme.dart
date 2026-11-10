import 'package:flutter/material.dart';

abstract final class FiningTheme {
  static const red = Color(0xffb71c35);
  static const paleRed = Color(0xffffe9ed);
  static const background = Color(0xfffff8f8);
  static const ink = Color(0xff281b1e);
  static const border = Color(0xffe6cdd2);

  static ThemeData get light {
    final colors = ColorScheme.fromSeed(seedColor: red).copyWith(
      primary: red,
      onPrimary: Colors.white,
      primaryContainer: paleRed,
      onPrimaryContainer: const Color(0xff790b20),
      secondary: red,
      onSecondary: Colors.white,
      secondaryContainer: paleRed,
      onSecondaryContainer: const Color(0xff790b20),
      surface: Colors.white,
      onSurface: ink,
      onSurfaceVariant: const Color(0xff655057),
      outline: const Color(0xff967b82),
      outlineVariant: border,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: red,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: border)),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: paleRed,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ink)),
      ),
      filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      )),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: red, width: 2)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: red, linearTrackColor: paleRed),
    );
  }
}
