import 'package:flutter/material.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle companyName = GoogleFonts.figtree(
    letterSpacing: -1.0,
    fontSize: 50,
    fontWeight: FontWeight.w800,
    color: AppColors.third,
  );
  static TextStyle companySubtitle = GoogleFonts.figtree(
    letterSpacing: 1.0,
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  static TextStyle title = GoogleFonts.figtree(
    letterSpacing: -1.0,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );
  static TextStyle habitTitle = GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );
  static TextStyle habitMotivation = GoogleFonts.figtree(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textLighter,
  );
  static TextStyle textLink = GoogleFonts.figtree(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle habitsCalendarDate = GoogleFonts.figtree(
    letterSpacing: -2.0,
    fontSize: 34,
    fontWeight: FontWeight.w900,
    color: AppColors.textLighter,
  );
  static TextStyle habitsCalendarDateWhite = GoogleFonts.figtree(
    letterSpacing: -2.0,
    fontSize: 34,
    fontWeight: FontWeight.w900,
    color: Colors.white.withOpacity(0.6),
  );
  static TextStyle currentDate = GoogleFonts.figtree(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 111, 125, 133),
  );
  static TextStyle habitsCalendarDay = GoogleFonts.figtree(
    letterSpacing: 0.0,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static TextStyle habitsCalendarDayWhite = GoogleFonts.figtree(
    letterSpacing: 0.0,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle profileCalendarDate = GoogleFonts.figtree(
    letterSpacing: -3.0,
    fontSize: 58,
    fontWeight: FontWeight.w700,
    color: Colors.white.withOpacity(0.5),
  );
  static TextStyle profileCalendarDay = GoogleFonts.figtree(
    letterSpacing: 0.0,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle fieldLabel = GoogleFonts.figtree(
    letterSpacing: 0.0,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static TextStyle textField = GoogleFonts.figtree(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static TextStyle daysOfWeekToogleButton = GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static TextStyle elevatedButtonCaption = GoogleFonts.figtree(
    letterSpacing: 2.0,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.background,
  );
  static TextStyle remainingCharacters = GoogleFonts.figtree(
    letterSpacing: 1,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );
  static TextStyle entryText = GoogleFonts.figtree(
    letterSpacing: 0.0,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
}

class AppButtonStyle {
  static ButtonStyle noShapeIconButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
  );
}
