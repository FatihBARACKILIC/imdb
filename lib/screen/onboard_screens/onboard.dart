import 'package:flutter/material.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/home/home_widget.dart';
import 'package:imdb/screen/onboard_screens/language_widget.dart';
import 'package:imdb/screen/onboard_screens/onboard_login_widget.dart';
import 'package:imdb/screen/onboard_screens/theme_widget.dart';
import 'package:imdb/screen/onboard_screens/welcome_widget.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardWidget extends StatefulWidget {
  const OnboardWidget({super.key});

  @override
  State<OnboardWidget> createState() => OnboardWidgetState();
}

class OnboardWidgetState extends State<OnboardWidget> {
  final _controller = PageController();
  int _currentPage = 0;
  final List<Widget> _onboardPages = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _onboardPages.add(const WelcomeWidget());
      _onboardPages.add(const LanguageWidget());
      _onboardPages.add(const ThemeWidget());
      _onboardPages.add(const OnboardLoginWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: [
            for (int i = 0; i < _onboardPages.length; i++) _onboardPages[i],
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: darkestColor,
          border: Border(
            top: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        height: 80,
        padding: const EdgeInsets.all(10),
        child: _currentPage == _onboardPages.length - 1
            ? ElevatedButton(
                onPressed: () async {
                  SharedPreferencesHelper.setSharedPreferences(
                      "showOnboardScreen", false);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeWidget(),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  foregroundColor: const MaterialStatePropertyAll(darkestColor),
                  backgroundColor:
                      const MaterialStatePropertyAll(imdbYellowColor),
                  minimumSize:
                      const MaterialStatePropertyAll(Size.fromHeight(60)),
                ),
                child: const Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: _currentPage > 0
                          ? imdbYellowColor
                          : Colors.grey.shade600,
                    ),
                    onPressed: _currentPage > 0
                        ? () => _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            )
                        : () {},
                    label: const Text("PREV"),
                    icon: const Icon(
                      Icons.navigate_before,
                      size: 30,
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: _onboardPages.length,
                      axisDirection: Axis.horizontal,
                      effect: const SlideEffect(
                        spacing: 8.0,
                        radius: 16.0,
                        dotWidth: 16.0,
                        dotHeight: 16.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.white,
                        activeDotColor: imdbYellowColor,
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: imdbYellowColor,
                      ),
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      ),
                      label: const Text("NEXT"),
                      icon: const Icon(
                        Icons.navigate_before,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
