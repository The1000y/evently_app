import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgetScreen extends StatelessWidget {
  ForgetScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var appProvider = context.read<AppProvider>();
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Card(
                          color: appProvider.isDark
                              ? AppColor.darkModeInputsColor
                              : AppColor.lightModeInputsColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              width: 2,
                              color: appProvider.isDark
                                  ? AppColor.darkModeMainColor.withValues(
                                      alpha: 0.3,
                                    )
                                  : AppColor.darkModeDisableColor.withValues(
                                      alpha: 0.3,
                                    ),
                            ),
                          ),
                          child: IconButton(
                            iconSize: 25,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppIds.loginSceen,
                              );
                            },
                            icon: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,

                                color: appProvider.isDark
                                    ? AppColor.darkModeMainTextColor
                                    : AppColor.lightModeMainColor,
                              ),
                            ),
                          ),
                        ),

                        Spacer(flex: 3),
                        Text(
                          "Forget Password",
                          style: myTheme.textTheme.titleLarge,
                        ),
                        Spacer(flex: 7),
                      ],
                    ),
                    SizedBox(height: 48),
                    Expanded(
                      child: Image.asset(
                        'assets/images/image_forget_password.png',
                        fit: BoxFit.contain,
                        color: appProvider.isDark ? Colors.white : null,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          bool emailValid = false;
                          if (value != null) {
                            emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value);
                          }
                          if (value == null || value.trim().isEmpty) {
                            return ' Enter your email';
                          } else if (!emailValid) {
                            return 'Unvalid email';
                          }
                          return null;
                        },
                        onTapUpOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },

                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                            color: appProvider.isDark
                                ? AppColor.darkModeMainTextColor
                                : AppColor.lightModeSecTextColor,
                          ),
                          prefixIcon: Icon(Iconsax.sms),

                          prefixIconColor: appProvider.isDark
                              ? AppColor.darkModeMainTextColor
                              : AppColor.darkModeDisableColor,
                        ),

                        textDirection: TextDirection.ltr,
                      ),
                    ),

                    SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  provider.resertPassword(
                                    context,
                                    email: emailController.text,
                                  );
                                  Future.delayed(
                                    Duration(milliseconds: 500),
                                    () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppIds.loginSceen,
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: appProvider.isDark
                                          ? Colors.redAccent
                                          : Colors.redAccent,
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,

                                            'Invalid input!',
                                          ),
                                        ],
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                        child: Center(child: Text('Reset password')),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
