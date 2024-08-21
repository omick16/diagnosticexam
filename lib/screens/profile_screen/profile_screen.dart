import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/login_controller.dart';
import 'package:go_habits/app/controllers/profile_controller.dart';
import 'package:go_habits/screens/profile_screen/widgets/date_blue_panel.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    final List<DateTime> days = controller.getDatesFromTodayUntilDaysAgo(20);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100.0,
        surfaceTintColor: AppColors.background,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.selectedDate.value,
                        style: AppTextStyle.currentDate,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text("Hi, ${controller.profileName.value}!",
                          style: AppTextStyle.title),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                width: 60,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: controller.imageUrl.value,
                  imageBuilder: (context, imageProvider) => GestureDetector(
                    onTap: () => showDialog<String>(
                      barrierColor: Colors.black.withOpacity(0.8),
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Sign Out'),
                        content:
                            const Text('Are you sure you want to sign out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.find<LoginController>().signOut();
                              Navigator.pop(context, 'YES');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 110,
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final date = days[index];

                return GestureDetector(
                    onTap: () {
                      controller.setSelectedDate(date);
                      controller.getHabitsWithJournalDate(
                          controller.selectedDateTime.value);
                      controller.setSelectedIndex(index);
                    },
                    child: Obx(
                      () => DateBluePanel(
                        date: date,
                        isSelected: controller.selectedIndex.value == index,
                      ),
                    ));
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: Obx(
            () => FutureBuilder<List<Map<String, dynamic>>>(
              future: controller
                  .getHabitsWithJournalDate(controller.selectedDateTime.value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("No habits with journal entry on this date"));
                }
                var habitsWithLogs = snapshot.data!;
                return ListView.builder(
                  itemCount: habitsWithLogs.length,
                  itemBuilder: (context, index) {
                    var habit = habitsWithLogs[index];
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppColors.third,
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      habit['habit']['name'],
                                      style: AppTextStyle.habitTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      habit['habit']['motivation'],
                                      style: AppTextStyle.habitMotivation,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 30,
                            color: AppColors.dividerColor,
                          ),
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: AppColors.third,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: habit['journals'][0]['imageUrl'],
                              imageBuilder: (context, imageProvider) =>
                                  GestureDetector(
                                onTap: () {},
                                child: Image(
                                  image: imageProvider,
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            habit['journals'][0]['entryText'],
                            textAlign: TextAlign.left,
                            style: AppTextStyle.entryText,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
