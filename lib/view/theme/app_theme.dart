import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color scaffoldBackGroundColor = Color(0xffffffff);
  static const Color educationCategoryColor = Color(0xffa7d9f6);
  static const Color sportsCategoryColor = Color(0xffFFECE6);
  static const Color meetingCategoryColor = Color(0xffFDF1DC);
  static const Color friendsCategoryColor = Color(0xffD0EDFF);
  static const Color elevatedButtonsColor = Color(0xff031dfe);
  static const Color textButtonColor = Color(0xfff0ecec);
  static const Color iconsColor = Color(0xff4e4c4a);
  static const Color activeIconColor = Color(0xff375deb);
  static const appBarColor = Color(0xfff0ecec);
  static const textFieldEnabledBorderColor = Color(0xff918ca6);
}

CustomTheme customTheme = CustomTheme();

class CustomTheme extends ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode getCurrentTheme() =>
      _isDarkTheme == false ? ThemeMode.light : ThemeMode.dark;
  void changeCurrentTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: AppColors.iconsColor),
        backgroundColor: AppColors.appBarColor,
        elevation: .1,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.iconsColor),
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackGroundColor,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.textFieldEnabledBorderColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: AppColors.iconsColor,
            width: 3,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        onSurface: AppColors.elevatedButtonsColor,
        onPrimary: AppColors.elevatedButtonsColor,
        elevation: 3,
        shadowColor: Colors.black,
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3),
          backgroundColor: MaterialStateProperty.all(
            AppColors.textButtonColor,
          ),
        ),
      ),
      textTheme: TextTheme(
        //*use this textTheme for the app bars
        labelMedium: GoogleFonts.arefRuqaa(
          color: AppColors.scaffoldBackGroundColor,
          fontSize: 24,
        ),
        headline1: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline2: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline3: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline4: GoogleFonts.b612(
          color: Colors.black,
        ),
        headline5: GoogleFonts.abrilFatface(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        headline6: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        button: GoogleFonts.arefRuqaa(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
