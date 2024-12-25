import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storedgev2/core/constants/constants.dart';

class AppTheme {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Roboto",
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: primaryColor,
          onPrimary: onPrimaryColor,
          surface: surfaceColor,
          onSurface: onSurfaceColor,
          surfaceContainer: surfaceContainer,
          surfaceContainerHigh: surfaceContainerHigh,
          onSurfaceVariant: onSurfaceVariant,
          /* Secs */
          secondary: surfaceColor,
          onSecondary: onSurfaceColor,
          error: Colors.redAccent,
          onError: onSurfaceColor,
        ),
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: surfaceColor, // Navigation bar
              statusBarColor: Colors.transparent, // Status bar
            ),
            elevation: 0,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: primaryColor, fontWeight: FontWeight.w500)),
        cardTheme: const CardTheme(
          clipBehavior: Clip.hardEdge,
          color: surfaceContainer,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultBorderRadious / 2))),
        ),
        buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size.fromHeight(50),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: onPrimaryColor))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          minimumSize: Size.fromHeight(50),
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          textStyle: const TextStyle(
              color: primaryColor,
              decoration: TextDecoration.underline,
              decorationThickness: 2),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultBorderRadious)),
            backgroundColor: primaryColor,
            foregroundColor: surfaceColor),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.transparent,
          filled: true,
        ),
        scaffoldBackgroundColor: surfaceColor,
        iconTheme: const IconThemeData(color: primaryColor),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: primaryColor),
        ),
        useMaterial3: false);
  }
}
