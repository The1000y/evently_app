import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/events/model/event_model.dart';
import 'package:evently/modules/events/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsEventScreen extends StatelessWidget {
  const DetailsEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    var myData = ModalRoute.of(context)!.settings.arguments as Map;
    var event = myData['event'] as EventModel;
    var category = myData['category'] as AppCategory;
    var date = event.date;
    DateTime dateTimeForUi = DateTime.parse(date);

    return ChangeNotifierProvider<EventProvider>(
      create: (BuildContext context) {
        return EventProvider();
      },
      child: Consumer<EventProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    CustomIconAppBar(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppIds.editEventSceen,
                          arguments: {'event': event, 'category': category},
                        );
                      },
                      appProvider: appProvider,
                      color1: AppColor.darkModeMainColor,
                      color2: AppColor.lightModeMainColor,
                      icon: Icon(
                        size: 30,
                        // weight: 10,
                        Icons.edit_outlined,
                        color: appProvider.isDark
                            ? AppColor.darkModeMainColor
                            : AppColor.lightModeMainColor,
                      ),
                    ),
                    CustomIconAppBar(
                      onTap: () {
                        provider.onDeleteEvent(event.id, context);
                      },
                      appProvider: appProvider,
                      color1: AppColor.darkModeMainColor,
                      color2: AppColor.lightModeMainColor,
                      icon: Icon(
                        size: 30,
                        // weight: 10,
                        Icons.delete_outlined,
                        color: AppColor.darkModeRedColor,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
              leadingWidth: MediaQuery.of(context).size.width * 0.3,
              leading: Row(
                children: [
                  SizedBox(width: 18),
                  CustomIconAppBar(
                    onTap: () => Navigator.pop(context),
                    appProvider: appProvider,
                    color1: AppColor.darkModeMainTextColor,
                    color2: AppColor.lightModeMainColor,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: appProvider.isDark
                          ? AppColor.darkModeMainTextColor
                          : AppColor.lightModeMainColor,
                    ),
                    // icon: Icons.arrow_back_ios_new_rounded,
                  ),
                ],
              ),

              title: Text('Edit Event', style: theme.textTheme.titleLarge),
            ),

            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: appProvider.isDark
                              ? AppColor.darkModeMainColor.withValues(
                                  alpha: 0.2,
                                )
                              : AppColor.darkModeDisableColor.withValues(
                                  alpha: 0.2,
                                ),
                          width: 2,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(category.image),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(event.title, style: theme.textTheme.titleLarge),
                    SizedBox(height: 16),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: appProvider.isDark
                            ? AppColor.darkModeStrokeColor.withValues(
                                alpha: 0.3,
                              )
                            : AppColor.darkModeMainTextColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: appProvider.isDark
                              ? AppColor.darkModeMainColor.withValues(
                                  alpha: 0.2,
                                )
                              : AppColor.darkModeDisableColor.withValues(
                                  alpha: 0.2,
                                ),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: appProvider.isDark
                                    ? AppColor.darkModeStrokeColor.withValues(
                                        alpha: 0.3,
                                      )
                                    : AppColor.lightModeDisableColor.withValues(
                                        alpha: 0.2,
                                      ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: appProvider.isDark
                                      ? AppColor.darkModeStrokeColor
                                      : AppColor.darkModeDisableColor
                                            .withValues(alpha: 0.2),
                                  width: 2,
                                ),
                              ),

                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: appProvider.isDark
                                    ? AppColor.darkModeMainColor
                                    : AppColor.darkModeStrokeColor,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('d MMMM').format(dateTimeForUi),
                                style: theme.textTheme.titleMedium,
                              ),
                              SizedBox(height: 4),
                              Text(
                                event.time,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    Text('Description', style: theme.textTheme.titleLarge),
                    SizedBox(height: 16),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      // height: 80,
                      decoration: BoxDecoration(
                        color: appProvider.isDark
                            ? AppColor.darkModeStrokeColor.withValues(
                                alpha: 0.3,
                              )
                            : AppColor.darkModeMainTextColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: appProvider.isDark
                              ? AppColor.darkModeMainColor.withValues(
                                  alpha: 0.2,
                                )
                              : AppColor.darkModeDisableColor.withValues(
                                  alpha: 0.2,
                                ),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          event.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomIconAppBar extends StatelessWidget {
  const CustomIconAppBar({
    super.key,
    required this.appProvider,
    required this.color1,
    required this.color2,
    required this.icon,
    this.onTap,
  });

  final AppProvider appProvider;
  final Color color1;
  final Color color2;
  final Icon icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appProvider.isDark
          ? AppColor.darkModeInputsColor
          : AppColor.lightModeInputsColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          width: 2,
          color: appProvider.isDark
              ? AppColor.darkModeMainColor.withValues(alpha: 0.3)
              : AppColor.darkModeDisableColor.withValues(alpha: 0.3),
        ),
      ),

      child: IconButton(
        iconSize: 25,
        onPressed: onTap,
        icon: Center(
          child: icon,

          //   child: Icon(
          //     icon,

          //     color: appProvider.isDark ? color1 : color2,

          //     // ? AppColor.darkModeMainTextColor
          //     // : AppColor.lightModeMainColor,
          //   ),
          // ),
        ),
      ),
    );
  }
}
