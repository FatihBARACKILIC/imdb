import 'package:flutter/material.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/login/login_widget.dart';
import 'package:imdb/screen/movies/movies.dart';
import 'package:imdb/screen/saved_movie/saved_movie.dart';
import 'package:imdb/screen/search/search.dart';
import 'package:imdb/screen/settings/setting_widget.dart';
import 'package:imdb/services/firebase_services.dart';
import 'package:imdb/theme/colors/colors.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _id = "";
  final List _userInfo = ["", "", ""];
  final List<Widget> _pageList = [
    const MoviesWidget(),
    const SearchWidget(),
    const SavedMoviesWidget(),
  ];
  int _pageIndex = 0;
  bool darkMode = true;

  @override
  void initState() {
    super.initState();
    getUserId();
    getDarkMode();
  }

  getDarkMode() async {
    bool result = await SharedPreferencesHelper.darkMode();
    setState(() {
      darkMode = result;
    });
  }

  getUserId() async {
    String result = await SharedPreferencesHelper.getLoginRegister();
    setState(() {
      _id = result;
      if (_id.isNotEmpty) {
        getUserInfo();
      }
    });
  }

  getUserInfo() async {
    List result = await FirebaseServices.getUserInfo(_id);
    setState(() {
      _userInfo[0] = result[0];
      _userInfo[1] = result[1];
      _userInfo[2] = result[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: () {
                        if (_id.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsWidget(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginWidget(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.person,
                      ),
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(
                          darkestColor,
                        ),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      label: Text(
                        _id.isNotEmpty
                            ? "Welcome ${_userInfo[0].split(" ")[0]}"
                            : "Login",
                      ),
                    ),
                  ),
                ),
                _pageList[_pageIndex],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Saved Movie",
            ),
          ],
          onTap: _onItemTapped,
          backgroundColor: imdbYellowColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: darkestColor,
          currentIndex: _pageIndex,
        ),
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
