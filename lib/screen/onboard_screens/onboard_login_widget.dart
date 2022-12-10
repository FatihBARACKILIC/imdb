import 'package:flutter/material.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/login/login_widget.dart';
import 'package:imdb/screen/signup/signup.dart';
import 'package:imdb/theme/colors/colors.dart';

class OnboardLoginWidget extends StatefulWidget {
  const OnboardLoginWidget({super.key});

  @override
  State<OnboardLoginWidget> createState() => _OnboardLoginWidgetState();
}

class _OnboardLoginWidgetState extends State<OnboardLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: FittedBox(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FittedBox(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Log in and save your all movie collections.",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            SharedPreferencesHelper.setSharedPreferences(
                                "showOnboardScreen", false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginWidget(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            foregroundColor:
                                const MaterialStatePropertyAll(darkestColor),
                            backgroundColor:
                                const MaterialStatePropertyAll(imdbYellowColor),
                            minimumSize: const MaterialStatePropertyAll(
                                Size.fromHeight(60)),
                          ),
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            SharedPreferencesHelper.setSharedPreferences(
                                "showOnboardScreen", false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpWidget(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            foregroundColor:
                                const MaterialStatePropertyAll(darkestColor),
                            backgroundColor: const MaterialStatePropertyAll(
                              purpleColor,
                            ),
                            minimumSize: const MaterialStatePropertyAll(
                                Size.fromHeight(60)),
                          ),
                          child: const Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
