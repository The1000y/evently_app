import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/events/services/event_services.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          TextFormField(
            style: myTheme.textTheme.bodyMedium,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: 'Search for event',
              hintStyle: myTheme.textTheme.bodyMedium,
              suffixIcon: Icon(Icons.search, color: myTheme.primaryColor),
            ),
          ),

          SizedBox(height: 16),
          Consumer<LayoutProvider>(
            builder: (context, provider, child) {
              return FutureBuilder(
                future: EventServices.getFavouriteDate(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data ?? [];
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var item = data[index].data();
                          var itemCategory = AppConstance.categories.firstWhere(
                            (element) => element.id == item.categoryId,
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
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemCount: data.length,
                      ),
                    );
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
