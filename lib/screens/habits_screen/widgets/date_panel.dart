import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/models/journal.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';
import 'package:intl/intl.dart';

class DatePanel extends StatelessWidget {
  final dynamic data;
  final String? habitId;

  const DatePanel({super.key, required this.data, required this.habitId});

  @override
  Widget build(BuildContext context) {
    DateTime date = data[0] as DateTime;
    String dayOfTheWeek = DateFormat('E').format(date);
    String day = DateFormat('d').format(date);
    String dayToday = DateFormat('d').format(DateTime.now());
    String imageURL = '';
    if (day == dayToday) {
      dayOfTheWeek = 'Today';
    }

    if (data[1] != null) {
      Journal entry = data[1] as Journal;
      imageURL = entry.imageUrl;
    }

    return GestureDetector(
      onTap: () {
        Get.offNamed(
          '/newJournal',
          arguments: {'date': date, 'habitId': habitId},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(0.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          shape: BoxShape.rectangle,
          color: Colors.white, // Optional background color inside the shadow
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            imageURL != ''
                ? Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: imageURL,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
            imageURL != ''
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              bottom: -13.0,
              right: 0.0,
              child: Text(
                day,
                style: imageURL != ''
                    ? AppTextStyle.habitsCalendarDateWhite
                    : AppTextStyle.habitsCalendarDate,
              ),
            ),
            Positioned(
              top: 7.0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  dayOfTheWeek,
                  style: imageURL != ''
                      ? AppTextStyle.habitsCalendarDayWhite
                      : AppTextStyle.habitsCalendarDay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
