import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/events/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  static String id = AppIds.addEventSceen;

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    List<AppCategory> categoriesList = AppConstance.categories;
    return ChangeNotifierProvider<EventProvider>(
      create: (context) => EventProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Add Event'),
        ),
        body: Consumer<EventProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AppConstance.categories[provider.tabIndex].image,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: BoxBorder.all(
                          width: 3,
                          color: AppColor.darkModeDisableColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    DefaultTabController(
                      length: categoriesList.length,
                      child: TabBar(
                        overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        // labelColor: AppColor.lightModeBackgroundColor,
                        // unselectedLabelColor: myTheme.primaryColorDark,
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        onTap: (value) {
                          provider.onChangeTab(value);
                        },

                        tabs: AppConstance.categories.asMap().entries.map((
                          element,
                        ) {
                          int index = element.key;
                          return Tab(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: provider.tabIndex == index
                                    ? myTheme.primaryColor
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      AppConstance.categories[index].icon,
                                      color: provider.tabIndex == index
                                          ? Colors.white
                                          : myTheme.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      element.value.name,
                                      style: myTheme.textTheme.titleSmall!
                                          .copyWith(
                                            color: provider.tabIndex == index
                                                ? Colors.white
                                                : myTheme.primaryColorDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 16),
                    Text('Title', style: myTheme.textTheme.titleMedium),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: provider.titleController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      decoration: InputDecoration(hint: Text('Event Title')),
                    ),
                    SizedBox(height: 14),
                    Text('Description ', style: myTheme.textTheme.titleMedium),

                    SizedBox(height: 4),
                    SizedBox(
                      height: 160,
                      child: TextFormField(
                        controller: provider.descriptionController,
                        onTapUpOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        maxLines: null,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        decoration: InputDecoration(
                          hint: Text('Event Description'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomRow(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ).then((value) {
                          provider.onSelectedDate(value ?? DateTime.now());
                        });
                      },
                      selecedName: provider.selectedDate != null
                          ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(provider.selectedDate!)
                          : 'Event Date',
                      myTheme: myTheme,
                      text: '  Event Date',
                      icon: Iconsax.calendar_1,
                    ),
                    SizedBox(height: 16),
                    CustomRow(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          provider.onSelectedTime(value ?? TimeOfDay.now());
                        });
                      },

                      selecedName: provider.selectedTime != null
                          ? provider.selectedTime!.format(context)
                          : 'Event Time',
                      myTheme: myTheme,
                      text: '  Event Time',
                      icon: Iconsax.clock,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.onAddEvent(context);
                      },
                      child: Center(child: Text('Add Event')),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.myTheme,
    required this.text,
    required this.icon,
    required this.selecedName,
    required this.onTap,
  });

  final ThemeData myTheme;
  final String text;
  final String selecedName;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: myTheme.primaryColor, size: 30),
        Text(text, style: myTheme.textTheme.titleMedium),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            selecedName,
            style: myTheme.textTheme.titleMedium!.copyWith(
              color: myTheme.primaryColor,
              decoration: TextDecoration.underline,

              decorationThickness: 1,
              decorationColor: myTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
