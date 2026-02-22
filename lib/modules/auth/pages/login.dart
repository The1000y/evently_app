import 'package:evently/core/ids/app_ids.dart';
import 'package:evently/core/provider/app_provider.dart';
import 'package:evently/core/themes/app_color.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final String id = AppIds.loginSceen;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isShow = ValueNotifier(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myTheme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
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
                              'Login to your account',
                              style: myTheme.textTheme.titleLarge!.copyWith(
                                color: appProvider.isDark
                                    ? AppColor.darkModeMainTextColor
                                    : AppColor.lightModeMainColor,
                              ),
                            ),
                            SizedBox(height: 26),
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

                            SizedBox(height: 24),

                            ValueListenableBuilder(
                              valueListenable: isShow,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: passwordController,
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
                            SizedBox(height: 8),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppIds.forgetScreen,
                                  );
                                },
                                child: Text(
                                  'Forget Password?',

                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: appProvider.isDark
                                        ? AppColor.darkModeMainColor
                                        : AppColor.lightModeMainColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: appProvider.isDark
                                        ? AppColor.darkModeMainColor
                                        : AppColor.lightModeMainColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 48),

                            Center(
                              child: ElevatedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          await provider.loginAccount(
                                            context,
                                            email: emailController.text,
                                            password: passwordController.text,
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
                                        }
                                      },
                                child: Center(
                                  child: provider.isLoading
                                      ? SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: appProvider.isDark
                                                ? AppColor.darkModeMainColor
                                                : AppColor.lightModeMainColor,
                                          ),
                                        )
                                      : Text('Login'),
                                ),
                              ),
                            ),

                            SizedBox(height: 48),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppIds.registerScreen,
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Don’t have an account ? ',
                                    style: myTheme.textTheme.titleMedium!
                                        .copyWith(
                                          color: appProvider.isDark
                                              ? AppColor.darkModeMainTextColor
                                              : AppColor.lightModeMainTextColor,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: 'Signup',
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
                          onPressed: () async {
                            try {
                              UserCredential? user = await provider
                                  .getSingInGoogle();
                              if (user != null && user.user != null) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppIds.layoutScreen,
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
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
