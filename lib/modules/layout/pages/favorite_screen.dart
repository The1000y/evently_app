import 'package:evently/core/constance/app_constance.dart';
import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    var appProvider = Provider.of<AppProvider>(context);
    var layoutProvider = Provider.of<LayoutProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      layoutProvider.getAllFavoriteEvents();
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              TextFormField(
                controller: layoutProvider.searchController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                style: myTheme.textTheme.bodyMedium,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) => layoutProvider.getAfterSearch(
                  layoutProvider.searchController.text,
                ),
                decoration: InputDecoration(
                  hintText: 'Search for event title',
                  hintStyle: myTheme.textTheme.bodyMedium,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (layoutProvider.searchController.text.isEmpty ||
                            layoutProvider.searchController.text == '') {
                          layoutProvider.getAllFavoriteEvents();
                          FocusManager.instance.primaryFocus?.unfocus();
                          return;
                        } else {
                          layoutProvider.getAfterSearch(
                            layoutProvider.searchController.text,
                          );
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      }
                    },
                    icon: Icon(Icons.search),
                    color: myTheme.primaryColor,
                  ),
                ),
              ),

              SizedBox(height: 16),
              Consumer<LayoutProvider>(
                builder: (context, provider, child) {
                  var data = provider.filteredFavoriteEvents;

                  if (provider.isLoadingFavorite) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.filteredFavoriteEvents.isEmpty) {
                    return Center(
                      child: Lottie.asset(
                        'assets/json_image/Empty box.json',
                        fit: BoxFit.cover,
                      ),
                      // child: Image.asset(
                      //   'assets/images/data_hacking-01.png',
                      //   cacheHeight: 400,
                      //   cacheWidth: 400,
                      // ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = data[index].data();
                      var itemCategory = AppConstance.categories(
                        context,
                      ).firstWhere((element) => element.id == item.categoryId);
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppIds.detailsEventSceen,
                            arguments: {
                              'event': item,
                              'category': itemCategory,
                            },
                          );
                        },
                        child: Container(
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
                              Align(
                                alignment: appProvider.language == 'en'
                                    ? Alignment.centerRight
                                    : Alignment.centerRight,
                                child: Container(
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
                                    style: myTheme.textTheme.titleSmall!
                                        .copyWith(
                                          color: appProvider.isDark
                                              ? AppColor.darkModeMainColor
                                              : AppColor.darkModeStrokeColor,
                                        ),
                                  ),
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
                                        style: myTheme.textTheme.titleSmall!
                                            .copyWith(
                                              color: appProvider.isDark
                                                  ? AppColor.darkModeMainColor
                                                  : AppColor
                                                        .darkModeStrokeColor,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkWell(
                                      onTap: () async {
                                        await provider.onTapFav(item);
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
                                      style: myTheme.textTheme.titleSmall!
                                          .copyWith(
                                            color: appProvider.isDark
                                                ? AppColor.darkModeMainColor
                                                : AppColor.darkModeStrokeColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                    itemCount: data.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
