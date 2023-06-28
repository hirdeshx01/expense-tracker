import 'package:expense_tracker/widgets/expenses_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) => runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.secondary,
            foregroundColor: kColorScheme.onSecondary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondary,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                bodyLarge: TextStyle(
                  color: kColorScheme.onPrimary,
                ),
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kColorScheme.onPrimary,
                ),
              ),
          bottomSheetTheme: const BottomSheetThemeData().copyWith(
            backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
          ),
        ),
        theme: ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.secondary,
            foregroundColor: kColorScheme.onSecondary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer.withOpacity(0.8),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kColorScheme.onBackground,
                ),
              ),
          iconTheme: const IconThemeData().copyWith(
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
        home: const ExpensesBackground(),
      ),
    ),
  );
}
