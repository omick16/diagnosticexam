import 'package:flutter/material.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';
import 'package:intl/intl.dart';

class DateBluePanel extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  const DateBluePanel(
      {super.key, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    String dayOfTheWeek = DateFormat('E').format(date);
    String day = DateFormat('d').format(date);
    String dayToday = DateFormat('d').format(DateTime.now());

    if (day == dayToday) {
      dayOfTheWeek = 'Today';
    }

    return Container(
      width: 80,
      margin: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppColors.endColor.withOpacity(0.4),
              offset: const Offset(1.1, 3.0),
              blurRadius: 10.0),
        ],
        gradient: isSelected
            ? const LinearGradient(
                colors: [
                  Color(0xFFFE95B6),
                  Color(0xFFFF5287),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  AppColors.startColor,
                  AppColors.endColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(34.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            left: -10,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.third.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -1,
            child: Text(
              day,
              style: AppTextStyle.profileCalendarDate,
            ),
          ),
          Positioned(
            top: 10,
            left: 15,
            child: Text(
              dayOfTheWeek,
              style: AppTextStyle.profileCalendarDay,
            ),
          ),
        ],
      ),
    );
  }
}
