import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final String id = AppIds.registerScreen;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isShow = ValueNotifier(true);
  final ValueNotifier<bool> isShow2 = ValueNotifier(true);
  // final ValueNotifier<String> passwordNotifier = ValueNotifier('');
  // String passwordNotifier2 = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) {
        return AuthProvider();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,

            child: SingleChildScrollView(
              child: Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AppIds.onBoardingScreen,
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
                          Hero(
                            tag: 'logo',
                            child: Center(
                              child: Image.asset(
                                'assets/logos/logo Evently.png',
                                width: 140,
                                color: myTheme.primaryColor,
                              ),
                            ),
                          ),
                          Spacer(flex: 7),
                        ],
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create your account',
                              style: myTheme.textTheme.titleLarge!.copyWith(
                                color: appProvider.isDark
                                    ? AppColor.darkModeMainTextColor
                                    : AppColor.lightModeMainColor,
                              ),
                            ),
                            SizedBox(height: 26),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter your name';
                                }
                                bool valiedName = RegExp(
                                  '[a-zA-Z]',
                                ).hasMatch(value);
                                if (!valiedName) {
                                  return 'Invalid Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.user),
                                prefixIconColor: appProvider.isDark
                                    ? AppColor.darkModeMainTextColor
                                    : AppColor.lightModeSecTextColor,
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                  color: appProvider.isDark
                                      ? AppColor.darkModeMainTextColor
                                      : AppColor.lightModeSecTextColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
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

                            SizedBox(height: 16),

                            ValueListenableBuilder(
                              valueListenable: isShow,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: passwordController,
                                  // onChanged: (value) {
                                  //   passwordNotifier2 = value;
                                  // },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter password';
                                    }
                                    if (value.length < 6) {
                                      return 'enther pawwsord moer than 6 characters';
                                    }
                                    bool validPasswod = RegExp(
                                      r'^(?=.*[^a-zA-Z0-9]).+$',
                                    ).hasMatch(value);

                                    if (!validPasswod) {
                                      return 'should contain at least one Special character';
                                    }
                                    return null;
                                  },
                                  obscureText: value,
                                  obscuringCharacter: "*",

                                  onTapUpOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },

                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: appProvider.isDark
                                          ? AppColor.darkModeMainTextColor
                                          : AppColor.lightModeSecTextColor,
                                    ),
                                    prefixIcon: Icon(Iconsax.lock),

                                    prefixIconColor: appProvider.isDark
                                        ? AppColor.darkModeMainTextColor
                                        : AppColor.darkModeDisableColor,

                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isShow.value = !isShow.value;
                                      },
                                      child: Icon(
                                        value ? Iconsax.eye_slash : Iconsax.eye,
                                      ),
                                    ),

                                    suffixIconColor: appProvider.isDark
                                        ? AppColor.darkModeMainTextColor
                                        : AppColor.darkModeDisableColor,
                                  ),

                                  textDirection: TextDirection.ltr,
                                );
                              },
                            ),

                            SizedBox(height: 16),

                            ValueListenableBuilder(
                              valueListenable: isShow2,
                              builder: (context, value, child) {
                                return TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter password';
                                    }
                                    if (value != passwordController.text) {
                                      return 'not match password';
                                    }
                                    if (value.length < 6) {
                                      return 'enther pawwsord moer than 6 characters';
                                    }
                                    bool validPasswod = RegExp(
                                      r'^(?=.*[^a-zA-Z0-9]).+$',
                                    ).hasMatch(value);

                                    if (!validPasswod) {
                                      return 'at least one Special character';
                                    }

                                    return null;
                                  },
                                  obscureText: value,
                                  obscuringCharacter: "*",

                                  onTapUpOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },

                                  decoration: InputDecoration(
                                    hintText: "Confirm your password",
                                    hintStyle: TextStyle(
                                      color: appProvider.isDark
                                          ? AppColor.darkModeMainTextColor
                                          : AppColor.lightModeSecTextColor,
                                    ),
                                    prefixIcon: Icon(Iconsax.lock),

                                    prefixIconColor: appProvider.isDark
                                        ? AppColor.darkModeMainTextColor
                                        : AppColor.darkModeDisableColor,

                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        isShow2.value = !isShow2.value;
                                      },
                                      child: Icon(
                                        value ? Iconsax.eye_slash : Iconsax.eye,
                                      ),
                                    ),

                                    suffixIconColor: appProvider.isDark
                                        ? AppColor.darkModeMainTextColor
                                        : AppColor.darkModeDisableColor,
                                  ),

                                  textDirection: TextDirection.ltr,
                                );
                              },
                            ),

                            SizedBox(height: 48),

                            Center(
                              child: ElevatedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          await provider.createAccount(
                                            context,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                          );
                                          provider.errorHappen
                                              ? ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        appProvider.isDark
                                                        ? Colors.redAccent
                                                        : Colors.redAccent,
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .error_outline_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,

                                                          'Invalid input!',
                                                        ),
                                                      ],
                                                    ),
                                                    duration: Duration(
                                                      seconds: 1,
                                                    ),
                                                  ),
                                                )
                                              : ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        appProvider.isDark
                                                        ? AppColor
                                                              .darkModeMainColor
                                                        : AppColor
                                                              .lightModeMainColor,
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text(
                                                          'Signup successful!',
                                                        ),
                                                      ],
                                                    ),
                                                    duration: Duration(
                                                      seconds: 1,
                                                    ),
                                                  ),
                                                );

                                          Future.delayed(
                                            Duration(seconds: 2),
                                            () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppIds.loginSceen,
                                              ); // بدل '/AppIds.loginSceen' بالصفحة اللي عايزها
                                            },
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  appProvider.isDark
                                                  ? Colors.redAccent
                                                  : Colors.redAccent,
                                              content: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .error_outline_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,

                                                    'Invalid input!',
                                                  ),
                                                ],
                                              ),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        }
                                      },
                                child: Center(
                                  child: provider.isLoading
                                      ? SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color:
                                                AppColor.darkModeMainTextColor,
                                          ),
                                        )
                                      : Text('Sign Up'),
                                ),
                              ),
                            ),

                            SizedBox(height: 48),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppIds.loginSceen,
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Already have an account ? ',
                                    style: myTheme.textTheme.titleMedium!
                                        .copyWith(
                                          color: appProvider.isDark
                                              ? AppColor.darkModeMainTextColor
                                              : AppColor.lightModeMainTextColor,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: 'Login',
                                        style: myTheme.textTheme.titleMedium!
                                            .copyWith(
                                              color: appProvider.isDark
                                                  ? AppColor.darkModeMainColor
                                                  : AppColor.lightModeMainColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2,
                                              decorationColor:
                                                  appProvider.isDark
                                                  ? AppColor.darkModeMainColor
                                                  : AppColor.lightModeMainColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),

                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    indent: 10,
                                    thickness: 2,
                                    color: appProvider.isDark
                                        ? AppColor.lightModeMainColor
                                        : AppColor.darkModeDisableColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    'Or',
                                    style: myTheme.textTheme.titleMedium!
                                        .copyWith(
                                          color: appProvider.isDark
                                              ? AppColor.darkModeMainColor
                                              : AppColor.lightModeMainColor,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    endIndent: 10,

                                    color: appProvider.isDark
                                        ? AppColor.lightModeMainColor
                                        : AppColor.darkModeDisableColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          style: myTheme.elevatedButtonTheme.style!.copyWith(
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: appProvider.isDark
                                    ? AppColor.lightModeMainColor
                                    : AppColor.darkModeSecTextColor,
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              appProvider.isDark
                                  ? AppColor.darkModeMainColor.withValues(
                                      alpha: 0.1,
                                    )
                                  : AppColor.darkModeMainTextColor,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              appProvider.isDark
                                  ? null
                                  : AppColor.lightModeMainColor,
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png'),
                              SizedBox(width: 20),
                              Text('Login with Google'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
