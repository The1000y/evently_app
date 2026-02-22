import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var myTheme = Theme.of(context);
    var appProvider = context.read<AppProvider>();
    List categoriesList = AppConstance.categories;

    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Column(
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back ✨',
                        style: myTheme.textTheme.titleLarge,
                      ),
                      Text(
                        currentUser!.displayName ?? "",
                        style: myTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Icon(
                  appProvider.isDark
                      ? Icons.dark_mode_outlined
                      : Icons.wb_sunny_outlined,
                  color: appProvider.isDark
                      ? AppColor.darkModeMainColor
                      : AppColor.lightModeMainColor,
                ),
                SizedBox(width: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: appProvider.isDark
                        ? AppColor.darkModeMainColor
                        : AppColor.lightModeMainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    appProvider.language.toUpperCase(),
                    style: myTheme.textTheme.titleMedium!.copyWith(
                      color: AppColor.darkModeMainTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Consumer<LayoutProvider>(
            builder: (context, provider, child) {
              return DefaultTabController(
                length: categoriesList.length + 1,
                child: TabBar(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
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

                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: provider.tabIndex == 0
                              ? myTheme.primaryColor
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.grid_view_rounded,
                                color: provider.tabIndex == 0
                                    ? Colors.white
                                    : myTheme.primaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'All',
                                style: myTheme.textTheme.titleSmall!.copyWith(
                                  color: provider.tabIndex == 0
                                      ? Colors.white
                                      : myTheme.primaryColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ...AppConstance.categories.asMap().entries.map((element) {
                      int index = element.key + 1;
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
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  AppConstance.categories[index - 1].icon,
                                  color: provider.tabIndex == index
                                      ? Colors.white
                                      : myTheme.primaryColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  element.value.name,
                                  style: myTheme.textTheme.titleSmall!.copyWith(
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
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 12),
          Consumer<LayoutProvider>(
            builder: (context, provider, child) {
              return StreamBuilder(
                stream: EventServices.getStreamDate(provider.tabIndex),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.docs ?? [];
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data[index].data();
                          var itemCategory = AppConstance.categories.firstWhere(
                            (element) {
                              return element.id == item.categoryId;
                            },
                          );
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColor.darkModeDisableColor.withValues(
                                  alpha: 0.2,
                                ),
                                width: 2,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(itemCategory.image),
                              ),
                            ),
                            width: double.infinity,
                            height: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: AppColor.darkModeDisableColor
                                          .withValues(alpha: 0.5),
                                    ),
                                    color: myTheme.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    DateFormat(
                                      "d MMM",
                                    ).format(DateTime.parse(item.date)),
                                    style: myTheme.textTheme.titleSmall,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      234,
                                      231,
                                      231,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.title,
                                          style: myTheme.textTheme.titleSmall,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          provider.onTapFav(item);
                                        },
                                        child: Icon(
                                          item.isfav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: myTheme.primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        item.userfav == null
                                            ? "0"
                                            : item.userfav!.length.toString(),
                                        style: myTheme.textTheme.titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
